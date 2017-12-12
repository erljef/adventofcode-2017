defmodule Day12 do
  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(rows) do
    rows
    |> Stream.map(&String.split/1)
    |> Stream.filter(fn x -> !Enum.empty? x end)
    |> Stream.map(fn row -> [from, "<->" | to] = row; {String.to_integer(from), Enum.map(to, fn i -> String.trim(i, ",") |> String.to_integer end)} end)
    |> Enum.to_list
  end

  def create_graph(nodes) do
    nodes
    |> Enum.reduce(Graph.new(type: :undirected), &add_nodes/2)
  end

  def add_nodes({from, to}, graph) do
    graph |> Graph.add_vertices([from | to]) |> Graph.add_edges(Enum.map(to, fn n -> {from, n} end))
  end

  def contains_group(input, group) do
    create_graph(input)
    |> Graph.components
    |> Enum.filter(fn component -> Enum.find(component, fn v -> v == group end) != nil end)
    |> Enum.flat_map(&(&1))
    |> Enum.count
  end

  def total_groups(input) do
    create_graph(input)
    |> Graph.components
    |> Enum.count
  end
end
