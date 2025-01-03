defmodule CliTest do
  use ExUnit.Case
  doctest ElixirIssues
  import ElixirIssues.CLI, only: [parse_args: 1]

  test ":help returned by passing -h and --help" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three values given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "default number of issues returned if no number of issues was passing" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end
end
