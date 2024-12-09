defmodule Solver do
  def solve(file_name) do
    text = File.read!(file_name)
    parse_file(text, [nil, nil], 0)
  end

  defp parse_file(<<>>, _, sum) do
    sum
  end
  defp parse_file(<< "mul(" :: utf8, rest :: binary >>, _, sum) do
    # When a mul(
    { char_int, rest } = parse_int(rest, "")
    if char_int !== "" do
      parse_file(rest, [char_int, nil], sum)
    else
      parse_file(rest, [nil, nil], sum)
    end
  end
  defp parse_file(<< _char :: utf8, rest :: binary >>, [nil, nil], sum) do
    # When nothing and just go on
    parse_file(rest, [nil, nil], sum)
  end
  defp parse_file(<< "," :: utf8, rest :: binary >>, [first_int, nil], sum) do
    # When first int found and comma after
    { char_int, rest } = parse_int(rest, "")
    if char_int !== "" do
      parse_file(rest, [first_int, char_int], sum)
    else
      parse_file(rest, [nil, nil], sum)
    end
  end
  defp parse_file(<< ")" :: utf8, rest :: binary >>, [first_int, second_int], sum) do
    # When both ints found and closing bracket
    parse_file(rest, [nil, nil], String.to_integer(first_int) * String.to_integer(second_int) + sum)
  end
  # When first int found mul(12 and no comma after
  defp parse_file(<< _ :: utf8, rest :: binary >>, [_, _], sum), do: parse_file(rest, [nil, nil], sum)

  defp parse_int(<< char :: utf8, rest :: binary >>, char_int) when char in ?0..?9 do
    parse_int(rest, "#{char_int}#{char - ?0}")
  end
  defp parse_int(rest, char_int), do: { char_int, rest }
end

answer = Solver.solve("input.txt")
IO.puts("Answer: #{answer}")