defmodule Day4 do
  def validate_file(path, method) do
    File.stream!(path)
    |> Stream.map(&String.split/1)
    |> Stream.map(method)
    |> Enum.to_list
    |> Enum.reduce(0, fn x, acc -> if x do acc + 1 else acc end end)
  end

  def validate_no_duplicates(phrase) do
    sorted = Enum.sort(phrase)
    sorted == Enum.uniq(sorted)
  end

  def validate_no_anagrams(phrase) do
    phrase
    |> Enum.map(fn s -> String.graphemes(s) |> Enum.sort |> Enum.join end)
    |> Enum.sort
    |> validate_no_duplicates
  end
end
