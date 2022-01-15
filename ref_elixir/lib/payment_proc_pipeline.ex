defmodule PaymentProc.Pipeline do
  # use GenStage
  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  @moduledoc """
  This module is used to process payments.

  ## Examples

      iex> PaymentProc.Pipeline.process()
      :world

  """

  @doc """
  This spec defines the get_payments stage.
  """
  @spec get_payments :: Stream
  def get_payments() do
    payment_file_path = Path.relative("./data/payments")

    payment_streams =
      for file <- File.ls!(payment_file_path) do
        File.stream!(payment_file_path <> "/" <> file, read_ahead: 100_000)
      end

    payment_streams
  end

  @spec parse_row(String) :: Stream
  def parse_row(row) do
    [row] = CSV.parse_string(row, skip_headers: false)

    %{
      id: Enum.at(row, 0),
      tenant: Enum.at(row, 1),
      type: Enum.at(row, 2),
      value: Enum.at(row, 3),
      created_at: Enum.at(row, 4),
      status: Enum.at(row, 5)
    }
  end

  @spec filter_data(Map) :: boolean()
  def filter_data(doc) do
    doc.status == "CLOSED" || doc.status == "status"
  end

  def process do
    Logger.info("#{inspect(__MODULE__)} start processing payments")

    get_payments()
    |> Flow.from_enumerables(max_demand: 100)
    |> Flow.partition(max_demand: 100, stages: 50)
    |> Flow.map(&parse_row/1)
    |> Flow.reject(&filter_data/1)
    |> Enum.to_list()
  end
end

# Commands
# PaymentProc.Pipeline.process()
