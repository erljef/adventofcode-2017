defmodule Adventofcode2017Test do
  use ExUnit.Case
  doctest Adventofcode2017

  test "solves day 1 first captcha" do
    assert Day1.solve_captcha("1122") == 3
    assert Day1.solve_captcha("1111") == 4
    assert Day1.solve_captcha("1234") == 0
    assert Day1.solve_captcha("91212129") == 9
  end

  test "solves day 1 second captcha" do
    assert Day1.solve_captcha_2("1212") == 6
    assert Day1.solve_captcha_2("1221") == 0
    assert Day1.solve_captcha_2("123425") == 4
    assert Day1.solve_captcha_2("123123") == 12
    assert Day1.solve_captcha_2("12131415") == 4
  end

  test "calculates day 2 checksum" do
    assert Day2.checksum("""
5 1 9 5
7 5 3
2 4 6 8
""") == 18
  end

  test "calculates day 2 evenly divisable values" do
    assert Day2.evenly_divisable("""
5 9 2 8
9 4 7 3
3 8 6 5
""") == 9
  end

  test "calculates day 3 distance" do
    assert Day3.distance(1) == 0
    assert Day3.distance(12) == 3
    assert Day3.distance(23) == 2
    assert Day3.distance(1024) == 31
  end

  test "calculates square spiral of sums of neighbours" do
    assert Day3.spiral_values |> Stream.take(10) |> Enum.to_list == [1, 1, 2, 4, 5, 10, 11, 23, 25, 26]
  end
end
