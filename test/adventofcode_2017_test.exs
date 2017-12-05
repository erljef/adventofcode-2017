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

  test "validates no duplicate words" do
    assert Day4.validate_no_duplicates(String.split("aa bb cc dd ee"))
    refute Day4.validate_no_duplicates(String.split("aa bb cc dd ee aa"))
    assert Day4.validate_no_duplicates(String.split("aa bb cc dd ee aaa"))
  end

  test "validates no anagrams" do
    assert Day4.validate_no_anagrams(String.split("abcde fghij"))
    refute Day4.validate_no_anagrams(String.split("abcde xyz ecdab"))
    assert Day4.validate_no_anagrams(String.split("a ab abc abd abf abj"))
    assert Day4.validate_no_anagrams(String.split("iiii oiii ooii oooi oooo"))
    refute Day4.validate_no_anagrams(String.split("oiii ioii iioi iiio"))
  end

  test "counts the number of steps to exit the list" do
    map = "0 3 0 1 -3" |> String.split |> Enum.map(&String.to_integer/1) |> Day5.to_map
    assert Day5.traverse(map) == 10
  end
end
