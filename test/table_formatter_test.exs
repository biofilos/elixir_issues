defmodule TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ElixirIssues.TableFormatter, as: TF

  @simple_test_data [
    [c1: "r1 c1", c2: "r1 c2", c3: "r1 c3", c4: "r1+++++++c4"],
    [c1: "r2 c1", c2: "r2 c2", c3: "r2 c3", c4: "r2+++++++c4"],
    [c1: "r3 c1", c2: "r3 c2", c3: "r3 c3", c4: "r3+++++++c4"],
    [c1: "r4 c1", c2: "r4ghc2", c3: "r4 c3", c4: "r4 c4"],
    [c1: "r5 c1", c2: "r5 c2", c3: "r5 c3", c4: "r5+c4"]
  ]
  @headers [:c1, :c2, :c4]

  def split_with_three_columns do
    TF.split_into_columns(@simple_test_data, @headers)
  end

  test "split into columns" do
    columns = split_with_three_columns()
    assert length(columns) == length(@headers)
  end

  test "Column widths" do
    widths = TF.widths_of(split_with_three_columns())
    assert widths == [5, 6, 11]
  end
end
