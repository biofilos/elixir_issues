defmodule ElixirIssues.CLI do
  import ElixirIssues.TableFormatter, only: [print_table_for_cols: 2]
  @default_count 4
  @moduledoc """
  Handle the command line arguments
  """
  def main(argv) do
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

  def process({user, project, count}) do
    ElixirIssues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_desc()
    |> last(count)
    |> print_table_for_cols(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching from Github: #{error}")
    System.halt(2)
  end

  def sort_desc(issues) do
    issues |> Enum.sort(fn i1, i2 -> i1["created_at"] >= i2["created_at"] end)
  end

  def last(list, count) do
    list |> Enum.take(count) |> Enum.reverse()
  end
end
