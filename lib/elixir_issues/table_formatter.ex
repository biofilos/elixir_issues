defmodule ElixirIssues.TableFormatter do
  import Enum, only: [each: 2, map: 2, map_join: 3, max: 1]

  def print_table_for_cols(rows, cols) do
    # with can execute code that matches.
    # it is similar to pattern matching, but instead
    # of raising when no match, it returns the value
    # in the left side of the match
    with data_by_columns = split_into_columns(rows, cols),
         columns_widths = widths_of(data_by_columns),
         format = format_for(columns_widths) do
      puts_one_line_in_columns(cols, format)
      IO.puts(separator(columns_widths))
      puts_in_columns(data_by_columns, format)
    end
  end

  def split_into_columns(rows, cols) do
    for col <- cols do
      for row <- rows do
        printable(row[col])
      end
    end
  end

  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  def widths_of(cols) do
    for col <- cols, do: col |> map(&String.length/1) |> max
  end

  def format_for(col_widths) do
    map_join(col_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(columns_widths) do
    map_join(columns_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> Enum.zip()
    |> map(&Tuple.to_list/1)
    |> each(&puts_one_line_in_columns(&1, format))
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
