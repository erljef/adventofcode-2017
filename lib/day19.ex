defmodule Day19 do
  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(rows) do
    rows
    |> Enum.to_list
    |> Enum.map(fn row -> row |> String.split("", trim: :true) end)
    |> Enum.filter(&(!Enum.empty?(&1)))
    |> Enum.map(fn row -> row |> Enum.with_index |> Enum.reduce(%{}, fn {char, x}, map -> map |> Map.put(x, char) end) end)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {row, y}, map -> map |> Map.put(y, row) end)
  end

  def find_start(map), do: Enum.find(map[0] |> Map.to_list, fn {_x, c} -> c == "|" end) |> elem(0)

  def traverse(map) do
    start = {find_start(map), 0}
    path = traverse(map, start, :down)
    Enum.reduce(path, {[], -1}, fn n, {chars, steps} -> if n != nil, do: {chars ++ [n], steps + 1}, else: {chars, steps + 1} end)
  end
  def traverse(_map, {_x, _y}, :stop), do: []
  def traverse(map, {x, y}, direction) do
    current = map[y][x]
    next_direction = direction(map, {x, y}, direction)
    next = next({x, y}, next_direction)
    if (String.to_charlist(current) |> hd) in ?A..?Z do
      [current] ++ traverse(map, next, next_direction)
    else
      [nil] ++ traverse(map, next, next_direction)
    end
  end

  def next({x, y}, direction) do
    case direction do
      :up -> {x, y - 1}
      :down -> {x, y + 1}
      :left -> {x - 1, y}
      :right -> {x + 1, y}
      :stop -> {x, y}
    end
  end

  def direction(map, {x, y}, direction) do
    case map[y][x] do
      "|" -> direction
      "+" -> case direction do
               ud when ud in [:up, :down] -> [:left, :right]
               lr when lr in [:left, :right] -> [:up, :down]
             end
             |> Enum.find(fn d -> {nx, ny} = next({x, y}, d); map[ny][nx] not in [" ", nil] end)
      " " -> :stop
      _ -> direction
    end
  end
end
