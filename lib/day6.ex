defmodule Day6 do
  def read_file(path) do
    File.stream!(path)
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list
  end

  def redistributions(input) do
    sequences(input)
    |> Enum.count
  end

  def cycles(input) do
    seqs = sequences(input, 2) |> Enum.to_list
    duplicate = duplicate(seqs)
    [first, second] = seqs
    |> Enum.with_index
    |> Enum.filter(&(elem(&1, 0) == duplicate))
    |> Enum.map(fn {_, index} -> index end)
    second - first
  end

  def duplicate([head | tail]) do
    case Enum.find_index(tail, &(&1 == head)) do
      nil -> duplicate(tail)
      x -> Enum.at(tail, x)
    end
  end

  def sequences(input, iterations \\ 1) do
    input
    |> Stream.unfold(fn acc -> { acc, redistribute(acc) } end)
    |> Stream.transform(%{}, fn seq, acc -> if Map.get(acc, seq, 0) < iterations, do: {[seq], Map.update(acc, seq, 1, &(&1 + 1))}, else: {:halt, acc} end)
  end

  def redistribute(input) do
    { max, index } = input |> Enum.with_index |> Enum.max_by(fn {x, _} -> x end)
    redistribute(List.replace_at(input, index, 0), index + 1, max, 0)
  end
  def redistribute(input, _, 0, _) do
    input
  end
  def redistribute(input, index, blocks, count) when index == length(input) do
    List.update_at(input, 0, &(&1 + 1))
    |> redistribute(1, blocks - 1, count + 1)
  end
  def redistribute(input, index, blocks, count) when index < length(input) do
    List.update_at(input, index, &(&1 + 1))
    |> redistribute(index + 1, blocks - 1, count)
  end

end
