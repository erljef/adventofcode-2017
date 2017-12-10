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

  test "counts the number of redistribution cycles for day 6" do
    input = String.split("0 2 7 0") |> Enum.map(&String.to_integer/1)
    assert Day6.redistributions(input) == 5
  end

  test "counts the number of cycles in the infinite loop for day 6" do
    input = String.split("0 2 7 0") |> Enum.map(&String.to_integer/1)
    assert Day6.cycles(input) == 4
  end

  test "determine the root of the day 7 tower" do
    input = """
        pbga (66)
        xhth (57)
        ebii (61)
        havc (66)
        ktlj (57)
        fwft (72) -> ktlj, cntj, xhth
        qoyq (66)
        padx (45) -> pbga, havc, qoyq
        tknk (41) -> ugml, padx, fwft
        jptl (61)
        ugml (68) -> gyxo, ebii, jptl
        gyxo (61)
        cntj (57)
    """
    |> String.split("\n")
    |> Day7.parse_input

    assert Day7.find_root(input)
  end

  test "determine the correct weight of the disc with faulty weight" do
    input = """
                pbga (66)
                xhth (57)
                ebii (61)
                havc (66)
                ktlj (57)
                fwft (72) -> ktlj, cntj, xhth
                qoyq (66)
                padx (45) -> pbga, havc, qoyq
                tknk (41) -> ugml, padx, fwft
                jptl (61)
                ugml (68) -> gyxo, ebii, jptl
                gyxo (61)
                cntj (57)
            """
            |> String.split("\n")
            |> Day7.parse_input
    assert Day7.find_unbalanced(input) == 60
  end

  test "calculate the largest register after processing instructions" do
    input = """
              b inc 5 if a > 1
              a inc 1 if b < 5
              c dec -10 if a >= 1
              c inc -20 if c == 10
            """
            |> String.split("\n")
            |> Day8.parse_input

    assert input |> Day8.process |> Day8.max_value == 1
  end

  test "calculate the largest register during processing instructions" do
    input = """
              b inc 5 if a > 1
              a inc 1 if b < 5
              c dec -10 if a >= 1
              c inc -20 if c == 10
            """
            |> String.split("\n")
            |> Day8.parse_input

    assert input |> Day8.process |> Day8.highest_value == 10
  end

  test "calculate the scores of different groups" do
    assert Day9.score("{}") == 1
    assert Day9.score("{{{}}}") == 6
    assert Day9.score("{{},{}}") == 5
    assert Day9.score("{{{},{},{{}}}}") == 16
    assert Day9.score("{<a>,<a>,<a>,<a>}") == 1
    assert Day9.score("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9
    assert Day9.score("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9
    assert Day9.score("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
  end

  test "count the removed garbage characters" do
    assert Day9.garbage("<>") == 0
    assert Day9.garbage("<random characters>") == 17
    assert Day9.garbage("<<<<>") == 3
    assert Day9.garbage("<{!>}>") == 2
    assert Day9.garbage("<!!>") == 0
    assert Day9.garbage("<!!!>>") == 0
    assert Day9.garbage("<{o\"i!a,<{i<a>") == 10
  end

  test "process the list for day 10" do
    input = 0..4 |> Enum.to_list
    lengths = "3,4,1,5" |> String.split(",") |> Enum.map(&String.to_integer/1)
    assert Day10.process(input, lengths) == [3, 4, 2, 1, 0]
    assert Day10.hash(input, lengths) == 12
  end
end
