defmodule Comtile38.Command.DocTest do
  @moduledoc """
  Module that contains every doctest for commands. They will be included
  both in the tests and in the documentation for each command function.
  """

  @doc """
  Function that returns the doctests for the command described with the given
  `canonical_command_name`.

  Each command can define a body of this function. By convention, the argument must
  must be the canonical name of the command.

  When no doctest is found, it returns `nil`.
  """
  def tests(canonical_command_name)
  def tests("script_flush") do
    """
        iex> Comtile38.client_list
        ["SCRIPT", "FLUSH"]
    """
  end

  def tests("server") do
    """
        iex> Comtile38.command
        ["SERVER"]
    """
  end

  def tests("stats") do
    """
        iex> Comtile38.command
        ["STATS"]
    """
  end

  def tests("quit") do
    """
        iex> Comtile38.quit
        ["QUIT"]
    """
  end
  def tests(_), do: nil
end
