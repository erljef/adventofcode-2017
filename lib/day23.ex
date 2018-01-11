defmodule Day23 do
  def read_file(path) do
    File.stream!(path)
    |> parse_input
  end

  def parse_input(rows) do
    rows
    |> Enum.to_list
  end

  def value(state, value_or_register) do
    case Integer.parse(value_or_register) do
      {v, _} -> v
      :error -> Map.get(state, value_or_register, 0)
    end
  end

  def update_index(state, value) do
    Map.update(state, :current_index, 0, &(&1 + value))
  end

  def process(instructions, apply_instruction, state \\ %{:current_index => 0}) do
    instruction = Enum.at(instructions, state[:current_index])
    if (instruction != nil) do
      new_state = apply_instruction.(state, instruction)
      process(instructions, apply_instruction, new_state)
    else
      state
    end
  end

  def apply_instruction(state, instruction) do
    case instruction |> String.split do
      ["set", x, y] -> vy = value(state, y); state |> Map.put(x, vy) |> update_index(1)
      ["sub", x, y] -> vy = value(state, y); state |> Map.update(x, vy, &(&1 - vy)) |> update_index(1)
      ["mul", x, y] -> vy = value(state, y); state |> Map.update(x, 0, &(&1 * vy)) |> Map.update(:mul_invoked, 1, &(&1 + 1)) |> update_index(1)
      ["jnz", x, y] -> vx = value(state, x); vy = value(state, y); if vx != 0, do: state |> update_index(vy), else: state |> update_index(1)
    end
  end

  def run(path) when is_binary(path) do
    run(path |> read_file)
  end
  def run(instructions) when is_list(instructions) do
    process(instructions, &apply_instruction/2, %{:current_index => 0})
  end

  def run_2 do
    b = 109900
    Range.new(b, b + 17000)
    |> Stream.take_every(17)
    |> Stream.filter(&(!is_prime?(&1)))
    |> Stream.take(1000)
    |> Enum.count
  end

  defp is_prime?(n) when n in [2, 3], do: true
  defp is_prime?(n) do
    floored_sqrt = :math.sqrt(n)
                   |> Float.floor
                   |> round
    !Enum.any?(2..floored_sqrt, &(rem(n, &1) == 0))
  end
end