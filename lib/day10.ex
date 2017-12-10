defmodule Day10 do
  def read_file(path) do
    {:ok, input} = File.read(path)
    input |> String.split(",") |> Enum.map(&String.to_integer/1)
  end

  def hash(list, lengths) do
    [first, second | _] = process(list, lengths)
    first * second
  end

  def process(list, lengths) do
    Enum.scan(
      lengths,
      {list, 0, 0},
      fn length, {lst, idx, skip} -> next(lst, idx, length, skip) end
    )
    |> Enum.map(fn {list, _, _} -> list end)
    |> List.last
  end

  def next(list, idx, length, skip) do
    {reverse(list, idx, length), rem(idx + length + skip, length(list)), skip + 1}
  end

  def reverse(list, current_idx, length) do
    list
    |> Stream.cycle
    |> Stream.take(length(list) * 2)
    |> Enum.to_list
    |> Enum.reverse_slice(current_idx, length)
    |> Enum.slice(current_idx, length(list))
    |> Day1.rotate_list(length(list) - current_idx)
  end
end
