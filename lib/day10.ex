defmodule Day10 do
  import Bitwise

  def read_file(path) do
    {:ok, input} = File.read(path)
    input
  end

  def to_integers(input) do
    input |> String.split(",") |> Enum.map(&String.to_integer/1)
  end

  def hash(list, lengths) do
    {l, _, _} = process(list, lengths)
    [first, second | _] = l
    first * second
  end

  def process(list, lengths, index \\ 0, skip \\ 0) do
    Enum.scan(
      lengths,
      {list, index, skip},
      fn length, {lst, idx, s} -> next(lst, idx, length, s) end
    )
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

  # Part 2

  def lengths(string) do
    String.to_charlist(string) ++ [17, 31, 73, 47, 23]
  end

  def sparse_hash(list, lengths) do
    Enum.scan(
      0..63,
      {list, 0, 0},
      fn _, {lst, idx, skip} -> process(lst, lengths, idx, skip) end
    )
    |> Enum.map(fn {list, _, _} -> list end)
    |> List.last
  end

  def dense_hash(sparse) do
    Enum.chunk_every(sparse, 16)
    |> Enum.map(fn chunk -> Enum.reduce(chunk, &bxor/2) end)
  end

  def to_hex(dense) do
    Base.encode16(:binary.list_to_bin(dense), case: :lower)
  end

  def knot_hash(input) do
    sparse_hash(0..255 |> Enum.to_list, lengths(input)) |> dense_hash |> to_hex
  end
end
