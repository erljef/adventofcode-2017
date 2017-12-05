defmodule Day5 do
  def read_file(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list
    |> to_map
  end

  def to_map(list) do
    list
    |> Enum.with_index
    |> Enum.into(%{}, fn {v, k} -> {k, v} end)
  end

  def traverse(input, current \\ 0, steps \\ 0)
  def traverse(input, current, steps) do
    case Map.fetch(input, current) do
      {:ok, step} -> traverse(input, current, steps, step)
      :error -> steps
    end
  end
  def traverse(input, current, steps, step) do
    next = step + current
    modify = fn x -> if x >= 3, do: x - 1, else: x + 1 end
    traverse(Map.put(input, current, modify.(step)), next, steps + 1)
  end
end
