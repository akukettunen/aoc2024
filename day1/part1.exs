defmodule Solver do
  def solve() do
    contents = File.read!("input.txt")
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "   "))

    [left, right] = zip(contents, [ [], [] ])
    [left_sorted, right_sorted] = [ Enum.sort(left), Enum.sort(right) ]

    get_difference_sum(left_sorted, right_sorted, 0)
  end

  defp zip([], [ left, right ]) do
    [ left, right ]
  end

  defp zip([[a, b] | rest], [ left, right ]) do
    zip(rest, [ left ++ [a], right ++ [b] ])
  end

  defp get_difference_sum([], [], sum) do
    IO.puts("Sum is #{sum}")
  end

  defp get_difference_sum([a | l_rest], [b | r_rest], sum) do
    get_difference_sum(l_rest, r_rest, sum + abs( String.to_integer(a) - String.to_integer(b) ))
  end
end

Solver.solve()