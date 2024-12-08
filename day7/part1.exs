defmodule Solver do
  def get_answer() do
    contents = File.read!("input.txt")
    solve(String.split(contents, "\n"), 0)
  end

  # Called when rows handled
  def solve([], sum) do IO.puts("Answer is #{sum}") end

  # Called for every row individually
  def solve(rows, sum) do
    [ row | rest ] = rows
    [ ans | tail ] = String.split( row, ":" )
    ans = String.to_integer( String.trim(ans) )

    vals
      = String.split( String.trim( hd(tail) ), " " )
      |> Enum.map( &String.trim/1 )

    new_sum = if can_be_formed(ans, vals), do: ans + sum, else: sum
    solve(rest, new_sum)
  end

  # Returns whether or not the answer can be formed
  def can_be_formed(ans, vals) do
    len = length(vals)
    cur_try = String.duplicate("1", len - 1) |> String.to_integer(2)

    try(cur_try, vals, ans, false)
  end

  def try(_, _, _, true) do
    true
  end

  def try(-1, _, _, _) do
    false
  end

  def try(cur_try, vals, answer, _found) do
    bit_list = Integer.to_string(cur_try, 2)
      |> String.graphemes()

    len = length(vals) - length(bit_list) - 1
    padding = List.duplicate("0", len)
    bit_list = padding ++ bit_list
    [ first_val | rest_vals ] = vals
    was_found = calculate(rest_vals, bit_list, String.to_integer(first_val)) === answer

    try(cur_try - 1, vals, answer, was_found)
  end

  def calculate([val | rest], ["1" | bits], acc) do
    calculate( rest, bits, acc * String.to_integer(val))
  end

  def calculate([val | rest], ["0" | bits], acc) do
    calculate( rest, bits, acc + String.to_integer(val) )
  end

  def calculate([], [], acc), do: acc
end

Solver.get_answer()