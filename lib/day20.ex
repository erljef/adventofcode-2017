defmodule Day20 do
  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(rows) do
    rows
    |> Stream.map(fn row -> Regex.scan(~r{(\w)=<([-\d]+),([-\d]+),([-\d]+)>}, row, capture: :all_but_first) end)
    |> Stream.map(fn row -> row |> Enum.map(fn [type | values] -> [type] ++ Enum.map(values, &String.to_integer/1) end) end)
    |> Stream.map(fn row -> row |> Enum.map(&List.to_tuple/1) end)
    |> Stream.filter(&(!Enum.empty?(&1)))
    |> Stream.map(fn row -> row |> List.to_tuple end)
    |> Enum.to_list
  end

  def tick({{"p", x, y, z}, {"v", vx, vy, vz}, {"a", ax, ay, az}}) do
    {{"p", x + vx + ax, y + vy + ay, z + vz + az}, {"v", vx + ax, vy + ay, vz + az}, {"a", ax, ay, az}}
  end
  def tick(particles) when is_list(particles) do
    particles |> Enum.map(&tick/1)
  end

  def tick(particles, times) do
    Enum.reduce(1..times, particles, fn _, p -> tick(p) end)
    |> Enum.with_index
    |> Enum.reduce(fn {particle, pi}, {closest, ci} -> if distance(particle) < distance(closest), do: {particle, pi}, else: {closest, ci} end)
  end

  def distance({{"p", x, y, z}, _, _}), do: abs(x) + abs(y) + abs(z)

  def particles_left(particles, times) do
    Enum.reduce(1..times, particles, fn _, p -> p |> remove_collision |> tick end)
    |> Enum.count
  end

  def remove_collision(particles) do
    counts = particles |> Enum.reduce(%{}, fn {location, _, _}, acc -> acc |> Map.update(location, 1, &(&1 + 1)) end)
    particles |> Enum.filter(fn particle -> {location, _, _} = particle; counts[location] < 2 end)
  end
end
