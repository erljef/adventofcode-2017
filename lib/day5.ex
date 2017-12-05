defmodule Day5 do
  def read_file(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list
  end

  def traverse_list(input, current \\ 0, steps \\ 0)
  def traverse_list(input, current, steps) when current >= length(input) do
    steps
  end
  def traverse_list(input, current, steps) do
    step = Enum.at(input, current)
    next = step + current
    if step >= 3 do
      traverse_list(List.replace_at(input, current, step - 1), next, steps + 1)
    else
      traverse_list(List.replace_at(input, current, step + 1), next, steps + 1)
    end
  end
end
