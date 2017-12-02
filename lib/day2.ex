defmodule Day2 do
  def checksum(input) do
    input
    |> to_arrays
    |> Enum.reduce(0, fn a, acc -> acc + (Enum.max(a) - Enum.min(a)) end)
  end

  def evenly_divisable(input) do
    input
    |> to_arrays
    |> Enum.reduce(0, fn a, acc -> acc + even_divide(a) end)
  end

  def to_arrays(input) do
    String.split(input, "\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn a -> Enum.map(a, &String.to_integer/1) end)
    |> Enum.filter(fn a -> !Enum.empty?(a) end)
  end

  def even_divide(row) do
    even_divisors =
      for a <- row,
          b <- row,
          a != b,
          rem(a, b) == 0,
          do: div(a, b)

      hd(even_divisors)
    end
end