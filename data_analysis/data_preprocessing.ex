# data_preprocessing.ex

defmodule DataPreprocessing do
  @moduledoc """
  Module for loading and cleaning datasets related to slum conditions.
  """

  def load_data(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        parse_data(content)
      {:error, reason} ->
        IO.puts("Failed to load data: #{reason}")
        nil
    end
  end

  defp parse_data(content) do
    # Assuming CSV format for simplicity
    content
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [housing_quality, sanitation_access, population_density] ->
      %{
        housing_quality: String.trim(housing_quality),
        sanitation_access: String.trim(sanitation_access),
        population_density: String.trim(population_density)
      }
    end)
  end

  def clean_data(data) do
    data
    |> Enum.filter(&valid_data?/1)
    |> Enum.map(&normalize_data/1)
  end

  defp valid_data?(%{housing_quality: hq, sanitation_access: sa, population_density: pd}) do
    hq != "" and sa != "" and pd != ""
  end

  defp normalize_data(%{housing_quality: hq, sanitation_access: sa, population_density: pd}) do
    %{
      housing_quality: normalize_value(hq),
      sanitation_access: normalize_value(sa),
      population_density: String.to_integer(pd)
    }
  end

  defp normalize_value(value) do
    # Normalization logic (e.g., convert to float or scale)
    case Float.parse(value) do
      {num, _} -> num / 10.0 # Example normalization by dividing by 10
      :error -> value # Return original if parsing fails
    end
  end
end

# Example usage:
file_path = "path/to/slum_conditions.csv"
data = DataPreprocessing.load_data(file_path)
cleaned_data = DataPreprocessing.clean_data(data)
IO.inspect(cleaned_data)
