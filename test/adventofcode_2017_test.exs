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
    {list, _, _} = Day10.process(input, lengths)
    assert list == [3, 4, 2, 1, 0]
    assert Day10.hash(input, lengths) == 12
  end

  test "calculates the knot hash for day 10" do
    assert Day10.knot_hash("") == "a2582a3a0e66e6e86e3812dcb672a272"
    assert Day10.knot_hash("AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd"
    assert Day10.knot_hash("1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d"
    assert Day10.knot_hash("1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e"
  end

  test "calculate number of steps to reach the end of the path" do
    assert Day11.steps(["ne", "ne", "ne"]) == 3
    assert Day11.steps(["ne", "ne", "sw", "sw"]) == 0
    assert Day11.steps(["ne", "ne", "s", "s"]) == 2
    assert Day11.steps(["se", "sw", "se", "sw", "sw"]) == 3
  end

  test "calculate number of steps to reach the furthest point of the path" do
    assert Day11.furthest(["ne", "ne", "ne"]) == 3
    assert Day11.furthest(["ne", "ne", "sw", "sw"]) == 2
    assert Day11.furthest(["ne", "ne", "s", "s"]) == 2
    assert Day11.furthest(["se", "sw", "se", "sw", "sw"]) == 3
  end

  test "determine the number of programs that contain group 0" do
    input = """
    0 <-> 2
    1 <-> 1
    2 <-> 0, 3, 4
    3 <-> 2, 4
    4 <-> 2, 3, 6
    5 <-> 6
    6 <-> 4, 5
    """ |> String.split("\n") |> Day12.parse_input
    assert Day12.contains_group(input, 0) == 6
  end

  test "determine the total number of groups" do
    input = """
    0 <-> 2
    1 <-> 1
    2 <-> 0, 3, 4
    3 <-> 2, 4
    4 <-> 2, 3, 6
    5 <-> 6
    6 <-> 4, 5
    """ |> String.split("\n") |> Day12.parse_input
    assert Day12.total_groups(input) == 2
  end

  test "calculate the severity of day 13" do
    input = """
    0: 3
    1: 2
    4: 4
    6: 4
    """
    |> String.split("\n") |> Day13.parse_input
    assert Day13.severity(input) == 24
  end

  test "calculate the minimum delay to pass through without getting caught" do
    input = """
    0: 3
    1: 2
    4: 4
    6: 4
    """
    |> String.split("\n") |> Day13.parse_input
    assert Day13.delay(input) == 10
  end

  test "calculate how many squares are used across the grid" do
    grid = Day14.grid("flqrgnkx")
    assert Day14.used_squares(grid) == 8108
  end

  test "calculate how many regions there are in the grid" do
    coordinates = Day14.grid("flqrgnkx") |> Day14.coordinates
    assert Day14.regions(coordinates) == 1242
  end

  test "find generator pairs" do
    assert Day15.count_pairs(65, 8921) == 588
  end

  test "find generator pairs with multiples of 4 and 8" do
    assert Day15.count_pairs_multiples(65, 8921) == 309
  end

  test "apply the instructions to the list" do
    list = "abcde" |> String.graphemes
    instructions = "s1,x3/4,pe/b" |> Day16.to_instructions
    assert Day16.process_instructions(list, instructions) |> Enum.join == "baedc"
  end

  test "apply the instructions to the list twice" do
    list = "abcde" |> String.graphemes
    instructions = "s1,x3/4,pe/b" |> Day16.to_instructions
    assert Day16.process_instructions(list, instructions, 2) |> elem(0) |> Enum.join == "ceadb"
  end

  test "fill the circular buffer and find the value after the last insert" do
    Day17.fill(3) == 638
  end

  test "process the instructions - day 18" do
    input = """
      set a 1
      add a 2
      mul a a
      mod a 5
      snd a
      set a 0
      rcv a
      jgz a -1
      set a 1
      jgz a -2
    """ |> String.split("\n")
    instructions = input |> Day18.parse_input
    assert Day18.process(instructions) == 4
  end
end
