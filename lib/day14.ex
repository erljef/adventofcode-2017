defmodule Day14 do
  def grid(input) do
    hashes = for row <- 0..127 do
      Task.async(fn () -> hash_row(input <> "-" <> Integer.to_string(row)) end)
    end

    hashes |> Enum.map(&(Task.await(&1, 300000))) |> Enum.map(&to_binary/1)
  end

  def hash_row(key) do
    Day10.knot_hash(key)
  end

  def to_binary(hash) when is_binary(hash) do
    hash |> String.graphemes |> Enum.map(fn char -> Integer.parse(char, 16) |> elem(0) end) |> Enum.flat_map(&to_binary/1)
  end

  def to_binary(number) when is_integer(number) do
    binary = Integer.digits(number, 2)
    List.duplicate(0, 4 - length(binary)) ++ binary
  end

  def used_squares(grid) do
    grid |> Enum.flat_map(&(&1)) |> Enum.reduce(&(&1 + &2))
  end

  def neighbours(coordinates, {x, y}) do
    [{x, y - 1}, {x + 1, y}, {x, y + 1}, {x - 1, y}]
    |> Enum.filter(&(MapSet.member?(coordinates, &1)))
  end

  def coordinates(grid) do
    grid_with_index = grid |> Enum.map(&Enum.with_index/1) |> Enum.with_index
    for {row, y} <- grid_with_index,
        {value, x} <- row,
        value == 1 do
      {x, y}
    end
  end

  def regions(coordinates) do
    coordinate_set = MapSet.new(coordinates)
    coordinates
    |> Enum.reduce(
         Graph.new,
         fn coordinate, graph ->
           neighbours = neighbours(coordinate_set, coordinate)
           Graph.add_vertex(graph, coordinate)
           |> Graph.add_vertices(neighbours)
           |> Graph.add_edges(neighbours |> Enum.map(fn c -> {coordinate, c} end))
         end
       )
    |> Graph.components
    |> Enum.count
  end
end
