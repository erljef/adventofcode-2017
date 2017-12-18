defmodule Day18 do
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
    case apply_instruction.(state, instruction) do
      %{:recovered => x, :last_played => x} -> x
      new_state -> process(instructions, apply_instruction, new_state)
    end
  end

  def apply_instruction_part1(state, instruction) do
    case instruction |> String.split do
      ["snd", x] -> state |> Map.put(:last_played, Map.get(state, x, 0)) |> update_index(1)
      ["set", x, y] -> vy = value(state, y); state |> Map.put(x, vy) |> update_index(1)
      ["add", x, y] -> vy = value(state, y); state |> Map.update(x, vy, &(&1 + vy)) |> update_index(1)
      ["mul", x, y] -> vy = value(state, y); state |> Map.update(x, 0, &(&1 * vy)) |> update_index(1)
      ["mod", x, y] -> vy = value(state, y); state |> Map.update(x, 0, &(rem(&1, vy))) |> update_index(1)
      ["rcv", x] -> vx = Map.get(state, x, 0); if vx != 0, do: state |> Map.put(:recovered, Map.get(state, :last_played)) |> update_index(1), else: state |> update_index(1)
      ["jgz", x, y] -> vx = Map.get(state, x, 0); vy = value(state, y); if vx > 0, do: state |> update_index(vy), else: state |> update_index(1)
    end
  end

  def apply_instruction_part2(state, instruction) do
    case instruction |> String.split do
      ["snd", x] -> send(state[:target], value(state, x)); state |> Map.update(:sent, 1, &(&1 + 1)) |> update_index(1)
      ["set", x, y] -> vy = value(state, y); state |> Map.put(x, vy) |> update_index(1)
      ["add", x, y] -> vy = value(state, y); state |> Map.update(x, vy, &(&1 + vy)) |> update_index(1)
      ["mul", x, y] -> vy = value(state, y); state |> Map.update(x, 0, &(&1 * vy)) |> update_index(1)
      ["mod", x, y] -> vy = value(state, y); state |> Map.update(x, 0, &(rem(&1, vy))) |> update_index(1)
      ["rcv", x] -> receive do v -> state |> Map.put(x, v) |> update_index(1) after 5_000 -> send(state[:parent], {self(), state[:sent]}); Process.exit(self(), :normal) end
      ["jgz", x, y] -> vx = value(state, x); vy = value(state, y); if vx > 0, do: state |> update_index(vy), else: state |> update_index(1)
    end
  end

  def process_file(path) do
    instructions = path |> read_file
    process(instructions, &apply_instruction_part1/2)
  end

  def run(path) when is_binary(path) do
    run(path |> read_file)
  end
  def run(instructions) when is_list(instructions) do
    p0 = spawn(
      fn () -> receive do
          init_state -> process(instructions, &apply_instruction_part2/2, init_state)
        end
      end
    )
    p1 = spawn(
      fn () -> receive do
          init_state -> process(instructions, &apply_instruction_part2/2, init_state)
        end
      end
    )

    send(p0, %{:current_index => 0, "p" => 0, :target => p1, :parent => self()})
    send(p1, %{:current_index => 0, "p" => 1, :target => p0, :parent => self()})

    receive do
      {^p1, sent} -> sent
    end
  end
end
