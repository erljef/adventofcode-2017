defmodule Day16 do

  def read_file(path) do
    {:ok, input} = File.read(path)
    input
  end

  def to_instructions(input) do
    input
    |> String.split(",")
    |> Enum.map(&to_instruction/1)
  end

  def to_instruction(str) do
    map = Regex.named_captures(~r{(?<type>[sxp])(?<a>[0-9a-z]+)(/(?<b>[0-9a-z]+))*}, str)
    case map do
      %{"type" => "s", "a" => a} -> {:s, String.to_integer(a)}
      %{"type" => "x", "a" => a, "b" => b} -> {:x, String.to_integer(a), String.to_integer(b)}
      %{"type" => "p", "a" => a, "b" => b} -> {:p, a, b}
    end
  end

  def apply_instruction(instruction, list) do
    case instruction do
      {:s, x} -> Enum.drop(list, length(list) - x) ++ Enum.take(list, length(list) - x)
      {:x, a, b} -> va = Enum.at(list, a); vb = Enum.at(list, b); list |> List.replace_at(a, vb) |> List.replace_at(b, va)
      {:p, va, vb} -> a = Enum.find_index(list, &(&1 == va)); b = Enum.find_index(list, &(&1 == vb)); list |> List.replace_at(a, vb) |> List.replace_at(b, va)
    end
  end

  def process_instructions(list, instructions) do
    instructions |> Enum.reduce(list, &apply_instruction/2)
  end

  def process_instructions(list, instructions, loops) do
    Enum.reduce_while(
      0..loops,
      {list, []},
      fn (i, {l, seen}) ->
        if Enum.find(seen, &(&1 == l)) != nil, do: {:halt, {Enum.at(seen, rem(loops, i)), seen}},
                                               else: {
                                                 :cont,
                                                 {process_instructions(l, instructions), seen ++ [l]}
                                               }
      end
    )
  end
end
