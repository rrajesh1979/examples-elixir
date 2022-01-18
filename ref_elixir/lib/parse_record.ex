defmodule ParseRecord do
  use Opus.Pipeline

  skip(:assert_suitable, if: :cacheable?)
  step(:retrieve_from_cache)

  def parse_row(row) do
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
