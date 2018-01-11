defmodule Day24 do
  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(rows) do
    rows
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.split(&1, "/"))
    |> Stream.map(fn v -> v |> Enum.map(&String.to_integer(&1)) |> List.to_tuple end)
    |> Enum.to_list
  end

  def strength(bridge) do
    Enum.reduce(bridge, 0, fn {a, b}, acc -> acc + a + b end)
  end

  def joinable?({a, b}, port), do: port == a || port == b
  def opposite_port({a, b}, port), do: if port == a, do: b, else: a

  def build(_, bridge, []), do: bridge
  def build(current_port, bridge, pieces) do
    pieces
    |> Enum.filter(&joinable?(&1, current_port))
    |> Enum.map(fn piece -> build(opposite_port(piece, current_port), bridge ++ [piece], Enum.filter(pieces, &(&1 != piece))) end)
    |> Enum.max_by(&strength/1, fn -> nil end)
    |> Kernel.||(bridge)
  end

  def strongest(pieces) do
    build(0, [], pieces) |> strength
  end
end