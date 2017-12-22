defmodule Day22 do
  use Bitwise

  def read_file(path) do
    File.stream!(path)
    |> Enum.to_list
    |> parse_input
  end

  def parse_input(rows) do
    map = rows
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(&parse_row/1)
    |> Enum.reduce(%{}, &Map.merge/2)

    size = rows |> Enum.count
    transform = -div(size, 2)
    map |> transform({transform, transform})
  end

  def parse_row({row, y}) do
    row
    |> String.graphemes
    |> Enum.with_index
    |> Enum.filter(fn {char, _} -> char == "#" end)
    |> Enum.map(fn {_, x} -> {x, y} end)
    |> Enum.map(fn coord -> {coord, :infected} end)
    |> Enum.into(%{})
  end

  def transform(map, {dy, dx}) do
    map |> Map.to_list |> Enum.map(fn {{y, x}, val} -> {{y + dy, x + dx}, val} end) |> Map.new
  end

  def turn(current_direction, :left) do
    case current_direction do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
    end
  end
  def turn(current_direction, :right) do
    case current_direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end
  def turn(current_direction, :reverse) do
    case current_direction do
      :north -> :south
      :east -> :west
      :south -> :north
      :west -> :east
    end
  end

  def move({x, y}, direction) do
    case direction do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end

  def step(_, _, _, infected, steps) when steps == 1, do: infected
  def step(map, current_position, direction, infected, steps) do
    status = Map.get(map, current_position, :clean)
    is_infected = status == :infected
    new_direction = if is_infected do
      turn(direction, :right)
    else
      turn(direction, :left)
    end

    new_map = map |> Map.put(current_position, (if is_infected, do: :clean, else: :infected))
    new_position = move(current_position, new_direction)

    infected = if is_infected, do: infected, else: infected + 1

    step(new_map, new_position, new_direction, infected, steps - 1)
  end

  def caused_infection(map, steps) do
    step(map, {0, 0}, :north, 0, steps)
  end

  def new_direction(status, direction) do
    case status do
      :clean -> turn(direction, :left)
      :weakened -> direction
      :infected -> turn(direction, :right)
      :flagged  -> turn(direction, :reverse)
    end
  end

  def new_status(status) do
    case status do
      :clean -> :weakened
      :weakened -> :infected
      :infected -> :flagged
      :flagged -> :clean
    end
  end

  def step2(_, _, _, infected, steps) when steps == 0, do: infected
  def step2(map, current_position, direction, infected, steps) do
    status = Map.get(map, current_position, :clean)
    new_direction = new_direction(status, direction)

    new_map = map |> Map.put(current_position, new_status(status))
    new_position = move(current_position, new_direction)

    infected = if status == :weakened, do: infected + 1, else: infected

    step2(new_map, new_position, new_direction, infected, steps - 1)
  end


  def caused_infection_part2(map, steps) do
    step2(map, {0, 0}, :north, 0, steps)
  end
end