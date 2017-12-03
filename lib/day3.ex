defmodule Day3 do

  def distance(number) do
    root = number |> :math.sqrt |> Float.ceil |> trunc
    side_length = if Integer.mod(root, 2) == 0 do root + 1 else root end
    square_number = trunc((side_length - 1) / 2)
    cycle = trunc(number - :math.pow(side_length - 2, 2))
    inner_offset = if side_length == 1 do 0 else Integer.mod(cycle, side_length - 1) end
    square_number + abs(inner_offset - square_number)
  end

  def steps do
    Stream.iterate(1, fn x -> x + 1 end)
    |> Stream.flat_map(fn x -> [x, x] end)
  end

  def directions do
    Stream.cycle([:right, :up, :left, :down])
    |> Stream.zip(steps())
    |> Stream.flat_map(fn {a, b} -> List.duplicate(a, b) end)
  end

  def coordinates do
    directions()
    |> Stream.scan({ 0, 0 }, fn direction, { x, y } ->
      case direction do
        :right -> { x + 1, y }
        :up ->    { x, y + 1 }
        :left ->  { x - 1, y }
        :down ->  { x, y - 1 }
      end
    end)
  end

  def neighbours({x1, y1}) do
    closest = for x <- [-1, 0, 1],
        y <- [-1, 0, 1],
        x != 0 || y != 0,
        do: {x, y}

    Enum.map(closest, fn { x, y } -> {x + x1, y + y1} end)
  end

  def accumulate({x, y}, acc) do
    value = neighbours({x, y})
            |> Enum.reduce(0, fn {x1, y1}, r -> r + Map.get(acc, {x1, y1}, 0) end)
    Map.put(acc, {x, y}, value)
  end

  def spiral_values do
    values = coordinates()
             |> Stream.transform(
                  %{{0, 0} => 1},
                  fn {x, y}, a -> {[Map.get(accumulate({x, y}, a), {x, y}, 0)], accumulate({x, y}, a)} end)
    Stream.concat([1], values)
  end
end
