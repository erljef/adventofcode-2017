defmodule Day25 do
  def read_file(path) do
    {:ok, input} = File.read(path)
    input
    |> parse_input
  end

  def parse_input(input) do
    [init_state] = Regex.run(~r{Begin in state (\w+)\.}, input, capture: :all_but_first)
    [steps] = Regex.run(~r{Perform a diagnostic checksum after (\d+) steps\.}, input, capture: :all_but_first)
    rules = Regex.scan(
      ~r{In state (\w+):
  If the current value is 0:
    - Write the value (\d)\.
    - Move one slot to the (\w+)\.
    - Continue with state (\w+)\.
  If the current value is 1:
    - Write the value (\d)\.
    - Move one slot to the (\w+)\.
    - Continue with state (\w+)\.},
      input,
      capture: :all_but_first)

    %{
      :initial_state => init_state,
      :steps => steps
                |> String.to_integer,
      :rules => rules
                |> Enum.map(
                     fn [state, if_0_write, if_0_move, if_0_next, if_1_write, if_1_move, if_1_next] ->
                       %{
                         :state => state,
                         0 => %{
                           :write => String.to_integer(if_0_write),
                           :move => move(if_0_move),
                           :next_state => if_0_next
                         },
                         1 => %{
                           :write => String.to_integer(if_1_write),
                           :move => move(if_1_move),
                           :next_state => if_1_next
                         }
                       }
                     end)
                |> Enum.reduce(%{}, fn rule, map -> map |> Map.put(rule[:state], rule) end)
    }
  end

  def move("left"), do: -1
  def move("right"), do: 1

  def step(acc, input) do
    current_value = Map.get(acc, acc[:index], 0)
    acc
    |> Map.put(acc[:index], input[:rules][acc[:state]][current_value][:write])
    |> Map.update(:index, 0, &(&1 + input[:rules][acc[:state]][current_value][:move]))
    |> Map.put(:state, input[:rules][acc[:state]][current_value][:next_state])
  end

  def checksum(input) do
    [state] = Stream.unfold(%{:index => 0, :state => input[:initial_state]}, fn acc -> val = step(acc, input); {val, val} end)
    |> Stream.drop(input[:steps] - 1)
    |> Stream.take(1)
    |> Enum.to_list

    Map.drop(state, [:index, :state])
    |> Map.values
    |> Enum.reduce(0, &(&1 + &2))
  end
end
