defmodule Comredis.Command.Generator do
  @moduledoc """
  Module responsible for generating at compile-time a function for each Redis command.
  """

  alias Comredis.{Command, Command.Argument, Command.DocTest, Command.FileReader}

  @doc """
  Macro that defines functions when this module is used.

  A function for each command is defined in the module that executes `use Comredis.Command.Generator`
  """
  defmacro __using__(_options) do
    commands = for command <- FileReader.load, do: generate(command)
    quote do
      Module.register_attribute __MODULE__, :commands, accumulate: true
      unquote(commands)
    end
  end

  defp generate(command = %Command{}) do
    quote do
      @commands unquote {
        command.canonical_name,
        String.to_atom(command.group)
      }
      @doc unquote doc(command)
      unquote bodies(command)
    end
  end

  defp doc(command) do
    doc_parts = [
      {command.summary, ":placeholder:"},
      {command.group, "*Group:* **:placeholder:**"},
      {command.since, "*Available since version* **:placeholder:**."},
      {command.complexity, "*Time complexity:* :placeholder:"},
      {arguments_doc(command.arguments), "*Arguments:*\n\n:placeholder:"},
      {DocTest.tests(command.canonical_name), "## Examples\n\n:placeholder:"},
    ]
    for {content, doc_part} <- doc_parts, content do
      String.replace(doc_part, ":placeholder:", content)
    end |> Enum.join("\n\n")
  end

  defp arguments_doc([]), do: nil
  defp arguments_doc(arguments) do
    for argument <- arguments do
      [
        "* `#{argument.canonical_name}`",
        [
          argument.optional && "optional",
          argument.multiple && "multiple",
          argument.type && (argument.type != argument.name) && inspect(argument.type) |> String.replace(~w("), ""),
          argument.enum && inspect(argument.enum),
        ] |> Enum.filter(&(&1)) |> Enum.join(", ")
      ] |> Enum.join(" ")
    end |> Enum.join("\n\n")
  end

  defp bodies(command) do
    {required_args, optional_args} = Argument.split_options(command.arguments)
    args = required_args |> Enum.map(fn argument -> { argument.canonical_name, [], Elixir} end)
    has_options = (optional_args != [])

    quote do
      if unquote(has_options) do
        def unquote(command.canonical_name)(unquote_splicing(args), opts \\ []) do
          List.flatten [unquote(command.name), unquote_splicing(args) | translate_options(unquote(command.canonical_name), opts)]
        end
      else
        def unquote(command.canonical_name)(unquote_splicing(args)) do
          List.flatten [unquote(command.name), unquote_splicing(args)]
        end
      end

      defp translate_options(command_name = unquote(command.canonical_name), opts) do
        arguments = unquote(command.arguments
                    |> Enum.map(fn command -> {command.canonical_name, Map.to_list(command) } end))

        arguments_opts = Enum.group_by(arguments ++ opts, fn {k, _} -> k end)

        translated_options = for {argument_key, list} <- arguments_opts, is_list(list), Enum.count(list) == 2 do
          {argument_key, argument, value} = case list do
            [{argument_key, value}, {argument_key, argument}] when argument |> is_list -> {argument_key, argument, value}
            [{argument_key, argument}, {argument_key, value}] when argument |> is_list -> {argument_key, argument, value}
          end

          case List.keyfind(argument, :command, 0) do
            {:command, command} when is_binary(command) -> { argument_key, [command, value] }
            _ -> { argument_key, [value] }
          end
        end

        Enum.filter_map arguments, fn {key, _} -> List.keymember?(translated_options, key, 0) end, fn {key, _} ->
          {_, value} = List.keyfind(translated_options, key, 0)
          value
        end
      end
    end
  end
end
