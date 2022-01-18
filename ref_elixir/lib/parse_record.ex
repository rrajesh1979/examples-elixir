defmodule ParseRecord do
  use Opus.Pipeline

  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  step(:parse_record)
  skip(:skip_record, if: &(&1.status == "CLOSED"))

  def parse_record(row) do
    Logger.info("Parsing record: #{row}")
    [row] = CSV.parse_string(row, skip_headers: false)

    %{
      id: Enum.at(row, 0),
      tenant: Enum.at(row, 1),
      type: Enum.at(row, 2),
      value: Enum.at(row, 3),
      created_at: Enum.at(row, 4),
      status: Enum.at(row, 5),
      activity_log: ["PARSED"]
    }
  end
end
