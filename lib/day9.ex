defmodule Day9 do
  def read_file(path) do
    {:ok, input} = File.read(path)
    input
  end

  def to_chars(input) do
    input |> String.split("") |> Enum.filter(fn s -> String.length(s) > 0 end)
  end

  def score(input), do: elem(parse(input), 0)
  def garbage(input), do: elem(parse(input), 1)

  def parse(input) when is_binary(input), do: input |> to_chars |> parse({1, 0})
  def parse(["{" | tail], {level, garbage}) do
    {l, g} = parse(tail, {level + 1, garbage})
    {l + level, g}
  end
  def parse(["}" | tail], {level, garbage}), do: parse(tail, {level - 1, garbage})
  def parse(["<" | tail], {level, garbage}), do: garbage(tail, {level, garbage})
  def parse([_ | tail], {level, garbage}), do: parse(tail, {level, garbage})
  def parse([], {_, garbage}), do: {0, garbage}

  def garbage(["!", _ | tail], {level, garbage}), do: garbage(tail, {level, garbage})
  def garbage([">" | tail], {level, garbage}), do: parse(tail, {level, garbage})
  def garbage([_ | tail], {level, garbage}), do: garbage(tail, {level, garbage + 1})
end
