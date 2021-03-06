defmodule AirportsFlowReduce do
  @moduledoc """
  Documentation for `AirportsFlowReduce`.
  """

  alias NimbleCSV.RFC4180, as: CSV

  def airports_csv() do
    Application.app_dir(:airports, "/priv/airports.csv")
  end

  def open_airports() do
    airports_csv()
    |> File.stream!()
    |> Flow.from_enumerable()
    |> Flow.map(fn row ->
      [row] = CSV.parse_string(row, skip_headers: false)

      %{
        id: Enum.at(row, 0),
        type: Enum.at(row, 2),
        name: Enum.at(row, 3),
        country: Enum.at(row, 8)
      }
    end)
    |> Flow.reject(&(&1.type == "closed"))
    |> Flow.partition(key: {:key, :country})
    |> Flow.reduce(
      fn -> %{} end,
      fn item, acc ->
        Map.update(acc, item.country, 1, &(&1 + 1))
      end
    )
    |> Enum.to_list()
  end
end
