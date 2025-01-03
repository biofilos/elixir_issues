defmodule ElixirIssues.CLI do
  @default_count 4
  @moduledoc """
  Handle the command line arguments
  """
  def run(argv) do
    argv |> parse_args |> process
  end

  @doc """
  `argv` can be -h or --help, which returns help.
  Otherwise, it is a github user name, project name, and
  optionally, the number of entries to format
  Return a tuple of `{user, project, count}`, or `:help`
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  def args_to_internal_representation([user, project]), do: {user, project, @default_count}
  def args_to_internal_representation(_), do: :help

  def process(:help) do
    IO.puts("Usage: elixir_issues <user> <project> [count | #{@default_count}]")
  end

  def process({user, project, _count}) do
    ElixirIssues.GithubIssues.fetch(user, project)
  end
end
