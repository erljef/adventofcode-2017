defmodule Day13 do
  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(rows) do
    rows
    |> Stream.filter(fn x -> String.length(x) > 0 end)
    |> Stream.map(fn row -> String.split(row) end)
    |> Stream.map(fn [wall, depth] -> {wall |> String.trim(":") |> String.to_integer, String.to_integer(depth)} end)
    |> Enum.to_list
  end

  def severity(walls) do
    for {wall, depth} <- walls,
        rem(wall, 2 * (depth - 1)) == 0 do
        wall * depth
     end
     |> Enum.reduce(0, &(&1 + &2))
  end

  def caught?(walls, delay) do
    walls |> Enum.any?(fn {wall, depth} -> rem((wall + delay), 2 * (depth - 1)) == 0 end)
  end

  def delay(walls, delay \\ 0) do
    case caught?(walls, delay) do
      true -> delay(walls, delay + 1)
      false -> delay
    end
  end
end
