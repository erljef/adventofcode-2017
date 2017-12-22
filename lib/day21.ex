defmodule Day21 do
  use Tensor

  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(rows) do
    rows
    |> Enum.map(&parse_rule/1)
    |> Enum.reduce([], fn {from, to}, acc -> acc ++ (variations(from) |> Enum.map(&({&1, to}))) end)
    |> Map.new
  end

  def parse_rule(row) do
    [from, to] = Regex.run(~r{([.#/]+) => ([.#/]+)}, row, capture: :all_but_first)
    {parse_pattern(from), parse_pattern(to)}
  end

  def parse_pattern(input) do
    pattern = input
    |> String.split("/")
    |> Enum.map(&(String.split(&1, "", trim: :true)))
    size = length(pattern |> hd)
    Matrix.new(pattern, size, size)
  end

  def variations(pattern) do
    [
      pattern,
      pattern |> Matrix.rotate_clockwise,
      pattern |> Matrix.rotate_180,
      pattern |> Matrix.rotate_counterclockwise,
      pattern |> Matrix.flip_horizontal,
      pattern |> Matrix.flip_horizontal |> Matrix.rotate_clockwise,
      pattern |> Matrix.flip_horizontal |> Matrix.rotate_180,
      pattern |> Matrix.flip_horizontal |> Matrix.rotate_counterclockwise
    ]
    |> Enum.uniq
  end

  def squares(pattern) do
    size = Matrix.width(pattern) * Matrix.height(pattern)
    square = if rem(size, 2) == 0, do: 2, else: 3

    pattern
    |> Matrix.to_list
    |> Enum.map(&(Enum.chunk_every(&1, square)))
    |> Enum.zip
    |> Enum.flat_map(&Tuple.to_list/1)
    |> Enum.chunk_every(square)
    |> Enum.map(&(Matrix.new(&1, square, square)))

    # squares by column (1, 4, 7, 2, 5, 8, 3, 6, 9)
  end

  def recombine(squares) do
    square_size = Matrix.width(squares |> hd)
    row_size = length(squares) |> :math.sqrt |> trunc
    squares
    |> Enum.chunk_every(row_size)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> List.flatten
    |> Enum.map(&Matrix.to_sparse_map/1)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {row, index}, acc -> Map.merge(acc, row |> Map.to_list |> Enum.map(fn {[y, x], v} -> {[y + square_size * div(index, row_size), x + rem((square_size * index), (row_size * square_size))], v} end) |> Map.new)  end)
    |> Matrix.from_sparse_map(square_size * row_size, square_size * row_size)
  end

  def initial do
    ".#./..#/###" |> parse_pattern
  end

  def step(pattern, rules) do
    pattern |> squares |> Enum.map(&(rules[&1])) |> recombine
  end

  def iterate(pattern, rules, times) do
    Enum.reduce(1..times, pattern, fn _, acc -> step(acc, rules) end)
  end

  def pixels(file, times) do
    iterate(initial(), read_file(file), times) |> Matrix.to_list |> List.flatten |> Enum.filter(&(&1 == "#")) |> Enum.count
  end
end
