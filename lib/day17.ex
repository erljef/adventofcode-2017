defmodule Day17 do

  def fill(steps) do
    {buffer, index} = Enum.reduce(
      1..2017,
      {[0], 0},
      fn val, {list, index} -> index = rem(index + steps, length(list)) + 1; {List.insert_at(list, index, val), index}
      end
    )
    Enum.at(buffer, index + 1)
  end

  def fill2(steps) do
    {at_1, index} = Enum.reduce(
      1..50000000,
      {0, 0},
      fn val, {at_1, index} -> index = rem(index + steps, val) + 1; if index == 1, do: {val, index}, else: {at_1, index}
      end
    )
    at_1
  end
end
