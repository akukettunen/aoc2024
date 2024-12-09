defmodule Solver do
  def solve(file_name), do: File.read!(file_name) |> parse_file([nil, nil], 0, true)

  defp parse_file(<<>>, _, sum, _), do: sum
  defp parse_file(<< "don't()" :: utf8, rest :: binary >>, _, sum, _), do: parse_file(rest, [nil, nil], sum, false)
  defp parse_file(<< "do" :: utf8, rest :: binary >>, _, sum, _), do: parse_file(rest, [nil, nil], sum, true)
  defp parse_file(<< "mul(" :: utf8, rest :: binary >>, _, sum, accepts) do
    { char_int, rest } = parse_int(rest, "")
    parse_file(rest, (if char_int !== "", do: [char_int, nil], else: [nil, nil]), sum, accepts)
  end
  defp parse_file(<< _char :: utf8, rest :: binary >>, [nil, nil], sum, accepts) do
    parse_file(rest, [nil, nil], sum, accepts)
  end
  defp parse_file(<< "," :: utf8, rest :: binary >>, [first_int, nil], sum, accepts) do
    { char_int, rest } = parse_int(rest, "")
    parse_file(rest, (if char_int !== "", do: [first_int, char_int], else: [nil, nil]), sum, accepts)
  end
  defp parse_file(<< ")" :: utf8, rest :: binary >>, [first_int, second_int], sum, accepts) do
    new_sum = if(accepts, do: String.to_integer(first_int) * String.to_integer(second_int) + sum, else: sum)
    parse_file(rest, [nil, nil], new_sum, accepts)
  end
  defp parse_file(<< _ :: utf8, rest :: binary >>, [_, _], sum, accepts), do: parse_file(rest, [nil, nil], sum, accepts)

  defp parse_int(<< char :: utf8, rest :: binary >>, char_int) when char in ?0..?9, do: parse_int(rest, "#{char_int}#{char - ?0}")
  defp parse_int(rest, char_int), do: { char_int, rest }
end

answer = Solver.solve("input.txt")
IO.puts("Answer: #{answer}")