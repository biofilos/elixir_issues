defmodule ElixirIssuesTest do
  use ExUnit.Case
  doctest ElixirIssues

  test "greets the world" do
    assert ElixirIssues.hello() == :world
  end
end
