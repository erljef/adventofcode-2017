defmodule Day1 do

  def solve_captcha(code) do
    sum_list(to_integer_list(code), 1)
  end

  def solve_captcha_2(code) do
    sum_list(to_integer_list(code), div(String.length(code), 2))
  end

  def sum_list(list, rotation) do
    Enum.zip(list, rotate_list(list, rotation))
    |> List.foldl(0, &add_if_equal/2)
  end

  def to_integer_list(code) do
    String.graphemes(code)
    |> Enum.map(&String.to_integer/1)
  end

  def rotate_list(list, steps) do
    Stream.drop(Stream.cycle(list), steps)
    |> Stream.take(Enum.count(list))
    |> Enum.to_list
  end

  def add_if_equal(current, acc) do
    if elem(current, 0) == elem(current, 1) do elem(current, 0) + acc else acc end
  end
end