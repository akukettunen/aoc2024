defmodule Solver do
  def solve(file_name) do
    text = File.read!(file_name)
    parse_file(text, [nil, nil], 0, true)
  end

  defp parse_file(<<>>, _, sum, _) do
    sum
  end
  defp parse_file(<< "don't()" :: utf8, rest :: binary >>, _, sum, _) do
    # Disables adding sums
    parse_file(rest, [nil, nil], sum, false)
  end
  defp parse_file(<< "do" :: utf8, rest :: binary >>, _, sum, _) do
    # Enables adding sums
    parse_file(rest, [nil, nil], sum, true)
  end
  defp parse_file(<< "mul(" :: utf8, rest :: binary >>, _, sum, accepts) do
    # When a mul(
    { char_int, rest } = parse_int(rest, "")
    if char_int !== "" do
      parse_file(rest, [char_int, nil], sum, accepts)
    else
      parse_file(rest, [nil, nil], sum, accepts)
    end
  end
  defp parse_file(<< _char :: utf8, rest :: binary >>, [nil, nil], sum, accepts) do
    # When nothing and just go on
    parse_file(rest, [nil, nil], sum, accepts)
  end
  defp parse_file(<< "," :: utf8, rest :: binary >>, [first_int, nil], sum, accepts) do
    # When first int found and comma after
    { char_int, rest } = parse_int(rest, "")
    if char_int !== "" do
      parse_file(rest, [first_int, char_int], sum, accepts)
    else
      parse_file(rest, [nil, nil], sum, accepts)
    end
  end
  defp parse_file(<< ")" :: utf8, rest :: binary >>, [first_int, second_int], sum, accepts) do
    # When both ints found and closing bracket
    new_sum = if(accepts, do: String.to_integer(first_int) * String.to_integer(second_int) + sum, else: sum)
    parse_file(rest, [nil, nil], new_sum, accepts)
  end
  # When first int found mul(12 and no comma after
  defp parse_file(<< _ :: utf8, rest :: binary >>, [_, _], sum, accepts), do: parse_file(rest, [nil, nil], sum, accepts)

  defp parse_int(<< char :: utf8, rest :: binary >>, char_int) when char in ?0..?9 do
    parse_int(rest, "#{char_int}#{char - ?0}")
  end
  defp parse_int(rest, char_int), do: { char_int, rest }
end

answer = Solver.solve("input.txt")
IO.puts("Answer: #{answer}")