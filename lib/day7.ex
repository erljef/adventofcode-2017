defmodule Day7 do
  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(input) do
    input
    |> Stream.map(&String.split/1)
    |> Stream.filter(fn x -> !Enum.empty? x end)
    |> Enum.to_list
    |> Enum.map(&row/1)
    |> Map.new(fn item -> {item[:name], item} end)
  end

  def row(list) do
    list
    |> Enum.filter(fn item -> item != "->" end)
    |> Enum.map(fn item -> String.trim(item, ",") end)
    |> Enum.reduce(%{}, &populate_map/2)
  end

  def populate_map(item, map) do
    cond do
      !Map.has_key?(map, :name) -> Map.put(map, :name, item)
      !Map.has_key?(map, :weight) -> Map.put(map, :weight, item |> String.trim("(") |> String.trim(")") |> String.to_integer)
      true -> Map.update(map, :children, [item], fn children -> children ++ [item |> String.trim(",")] end)
    end
  end

  def find_root(discs) do
    find_root(discs, discs |> Map.values |> hd)
  end
  def find_root(discs, disc) do
    parent = parent(discs, disc)
    if parent == nil do
      disc
    else
      find_root(discs, parent)
    end
  end

  def parent(discs, disc) do
    discs |> Map.values |> Enum.find(fn d -> Enum.find(Map.get(d, :children, []), fn child -> child == disc[:name] end) end)
  end

  def children(discs, disc) do
    Map.get(disc, :children, []) |> Enum.map(fn name -> discs[name] end)
  end

  def tree_weight(discs, disc) do
    disc[:weight] + (subtree_weights(discs, disc) |> Enum.reduce(0, &(&1 + &2)))
  end

  def subtree_weight(discs, disc) do
    children(discs, disc) |> Enum.reduce(0, fn child, acc -> acc + child[:weight] + subtree_weight(discs, child) end)
  end

  def subtree_weights(discs, disc) do
    children(discs, disc) |> Enum.map(fn disc -> disc[:weight] + subtree_weight(discs, disc) end)
  end

  def find_unbalanced(discs) do
    find_unbalanced(discs, find_root(discs))
  end
  def find_unbalanced(discs, disc) when is_map(disc) do
    children = children(discs, disc)
    if is_balanced?(discs, disc) do
      0
    else
      balanced_children = children |> Enum.map(fn child -> is_balanced?(discs, child) end)
      if balanced_children |> Enum.filter(&(&1)) |> Enum.count == length(children) do
        groups = children |> Enum.group_by(fn child -> tree_weight(discs, child) end)
        w = groups |> Enum.find(fn {_, list} -> length(list) == 1 end)
        c = groups |> Enum.find(fn {_, list} -> length(list) > 1 end)
        {_, [wrong]} = groups |> Enum.find(fn {_, list} -> length(list) == 1 end)
        {_, [correct | _]} = groups |> Enum.find(fn {_, list} -> length(list) > 1 end)
        wrong[:weight] - (tree_weight(discs, wrong) - tree_weight(discs, correct))
      else
        Map.get(disc, :children, []) |> Enum.map(fn child -> find_unbalanced(discs, discs[child]) end) |> Enum.max
      end
    end
  end

  def is_balanced?(discs, disc) do
    is_balanced?(subtree_weights(discs, disc))
  end
  def is_balanced?(weights) do
    MapSet.new(weights) |> MapSet.size == 1
  end
end