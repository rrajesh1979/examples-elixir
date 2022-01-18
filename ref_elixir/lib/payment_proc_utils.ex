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
end
