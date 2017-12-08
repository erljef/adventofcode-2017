defmodule Day8 do
  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(rows) do
    rows
    |> Stream.map(&String.split/1)
    |> Stream.filter(fn x -> !Enum.empty? x end)
    |> Enum.to_list
  end

  def process_instruction(row, registers) do
    [register, instruction, amount, if_test, test_reg, test_op, test_num] = row
    test_r_value = Map.get(registers, test_reg, 0)
    # TODO: rewrite with eval_quoted?
    test = case test_op do
      ">" -> &(&1 > &2)
      "<" -> &(&1 < &2)
      ">=" -> &(&1 >= &2)
      "<=" -> &(&1 <= &2)
      "==" -> &(&1 == &2)
      "!=" -> &(&1 != &2)
    end
    inst = case instruction do
      "inc" -> &(&1 + &2)
      "dec" -> &(&1 - &2)
    end

    initial_value = if test.(test_r_value, String.to_integer(test_num)), do: inst.(0, String.to_integer(amount)), else: 0
    Map.update(
      registers,
      register,
      initial_value,
      fn v -> if test.(test_r_value, String.to_integer(test_num)), do: inst.(v, String.to_integer(amount)), else: v  end
    )
    |> Map.update(:_highest, Map.get(registers, register, 0), fn v -> Enum.max([v, Map.get(registers, register, 0)]) end)
  end

  def process(rows) do
    rows |> Enum.reduce(%{}, &process_instruction/2)
  end

  def max_value(registers) do
    registers |> Map.drop([:_highest]) |> Map.values |> Enum.max
  end

  def highest_value(registers) do
    Map.get(registers, :_highest, 0)
  end

end
