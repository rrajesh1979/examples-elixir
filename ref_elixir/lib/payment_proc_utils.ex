defmodule PaymentProc.Utils do
  alias NimbleCSV.RFC4180, as: CSV

  @doc """
  This spec defines the get_payments stage.
  """
  @spec get_payments :: Stream
  def get_payments() do
    payment_file_path = Path.relative("./data/payments")

    payment_streams =
      for file <- File.ls!(payment_file_path) do
        File.stream!(payment_file_path <> "/" <> file, read_ahead: 100_000)
        |> Stream.drop(1)
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
end
