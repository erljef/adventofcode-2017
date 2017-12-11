defmodule Day11 do
  def read_file(path) do
    {:ok, input} = File.read(path)
    input
  end

  def to_directions(input) do
    input |> String.split(",")
  end

  def next(direction, {x, y, z}) do
    case direction do
      "n" -> {x, y + 1, z - 1}
      "ne" -> {x - 1, y + 1, z}
      "se" -> {x - 1, y, z + 1}
      "s" -> {x, y - 1, z + 1}
      "sw" -> {x + 1, y - 1, z}
      "nw" -> {x + 1, y, z - 1}
    end
  end

  def distance({x1, y1, z1}, {x2, y2, z2}) do
    [abs(x2 - x1), abs(y2 - y1), abs(z2 - z1)] |> Enum.max
  end

  def steps(directions) do
    {distance, _} = travel(directions)
    distance
  end

  def furthest(directions) do
    {_, max} = travel(directions)
    max
  end

  def travel(directions) do
    origin = {0, 0, 0}
    {destination, max} = directions |> Enum.reduce({origin, 0}, fn direction, {coordinate, max} -> next_with_max(direction, coordinate, max) end)
    {distance(origin, destination), max}
  end

  def next_with_max(direction, coordinate, current_max) do
    next = next(direction, coordinate)
    distance_to_next = distance({0, 0, 0}, next)
    {next, max(current_max, distance_to_next)}
  end
end
