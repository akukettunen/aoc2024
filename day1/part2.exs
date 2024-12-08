defmodule Solver do
  def solve() do
    contents = File.read!("input.txt")
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "   "))

    [left, right] = zip(contents, [ [], [] ])
    right_sorted = Enum.sort(right)

    ans = get_similarity_score(left, right_sorted, 0)

    IO.puts("Answer is #{ans}")
  end

  defp zip([], [ left, right ]) do
    [ left, right ]
  end

  defp zip([[a, b] | rest], [ left, right ]) do
    zip(rest, [ left ++ [a], right ++ [b] ])
  end

  defp get_similarity_score([], _, sum) do
    sum
  end

  defp get_similarity_score([a | l_rest], right, sum) do
    matches =  count_matches(a, right, 0)

    get_similarity_score(l_rest, right, sum + ( matches * String.to_integer(a) ))
  end

  defp count_matches(_, [], found) do
    found
  end

  defp count_matches(val, [ to_match | rest_r ], found) do
    new_found = if val === to_match, do: found + 1, else: found
    count_matches(val, rest_r, new_found)
  end
end

Solver.solve()