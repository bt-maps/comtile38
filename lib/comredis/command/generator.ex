defmodule Comredis.Command.Generator do
  alias Comredis.Command
  alias Comredis.Command.{FileReader, Generator}

  def doc(command) do
    basic_doc = """
    #{command.summary}

    *Group:* #{command.group}

    *Available since Redis version #{command.since}.*
    """
    case command.complexity do
      nil -> basic_doc
      complexity -> "#{basic_doc}\n*Time complexity:* #{complexity}"
    end
  end

  defmacro __using__(_options) do
    for command <- FileReader.load do
      generate(command)
    end
  end

  defp generate(command) do
    args = command.arguments
            |> Enum.map(&(&1.name || &1.command))
            |> Enum.join(", ")
    quote do
      @doc unquote(doc(command))
      unquote Code.string_to_quoted! """
      def #{command.function_name}(#{args}) do
        ["#{command.name}" | [#{args}]]
      end
      """
    end
  end
end
