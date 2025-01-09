# computation_module.ex

defmodule ComputationModule do
  @moduledoc """
  Module for general computation tasks like data aggregation and summary statistics.
  """

  def aggregate_data(data, key) do
    data
    |> Enum.group_by(&Map.get(&1, key))
    |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
    |> Enum.into(%{})
  end

  def summary_statistics(data) do
    n = length(data)
    mean = Enum.sum(data) / n
    variance = Enum.reduce(data, 0, fn x, acc -> acc + :math.pow(x - mean, 2) end) / n
    std_dev = :math.sqrt(variance)

    %{
      count: n,
      mean: mean,
      variance: variance,
      std_dev: std_dev
    }
  end

  def calculate_statistics_for_key(data, key) do
    values = Enum.map(data, &Map.get(&1, key))
    summary_statistics(values)
  end
end

# Example usage:
data = [
  %{category: "A", value: 10},
  %{category: "A", value: 20},
  %{category: "B", value: 30},
  %{category: "B", value: 40}
]

IO.inspect(ComputationModule.aggregate_data(data, :category))
IO.inspect(ComputationModule.calculate_statistics_for_key(data, :value))
