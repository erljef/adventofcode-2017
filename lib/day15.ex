defmodule Day15 do
  import Bitwise

  def count_pairs(startA, startB) do
    genA = Stream.unfold(startA, fn val -> next = rem(val * 16807, 2147483647); {next, next} end)
    genB = Stream.unfold(startB, fn val -> next = rem(val * 48271, 2147483647); {next, next} end)
    pairs = Stream.zip(genA, genB)

    for {a, b} <- Stream.take(pairs, 40000000),
        (a &&& 0xFFFF) == (b &&& 0xFFFF) do
      1
    end
    |> Enum.count
  end

  def count_pairs_multiples(startA, startB) do
    genA = Stream.unfold(startA, fn val -> next = rem(val * 16807, 2147483647); {next, next} end)
           |> Stream.filter(fn val -> rem(val, 4) == 0 end)
    genB = Stream.unfold(startB, fn val -> next = rem(val * 48271, 2147483647); {next, next} end)
           |> Stream.filter(fn val -> rem(val, 8) == 0 end)
    pairs = Stream.zip(genA, genB)

    for {a, b} <- Stream.take(pairs, 5000000),
        (a &&& 0xFFFF) == (b &&& 0xFFFF) do
      1
    end
    |> Enum.count
  end

end
