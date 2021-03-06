defmodule AirportsSimple do
  @moduledoc """
  Documentation for `AirportsSimple`.
  """

  alias NimbleCSV.RFC4180, as: CSV

  def airports_csv() do
    Application.app_dir(:airports, "/priv/airports.csv")
  end

  def open_airports() do
    airports_csv()
    |> File.read!()
    |> CSV.parse_string()
    |> Enum.map(fn row ->
      %{
        id: Enum.at(row, 0),
        type: Enum.at(row, 2),
        name: Enum.at(row, 3),
        country: Enum.at(row, 8)
      }
    end)
    |> Enum.reject(&(&1.type == "closed"))
  end

  def benchmark_run() do
    Benchee.run(
      %{
        "parse csv" => fn ->
          open_airports()
        end
      },
      time: 10,
      memory_time: 2
    )
  end
end
