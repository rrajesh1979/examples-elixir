defmodule SkipInvalidRecords do
  use Opus.Pipeline
  require Logger

  skip(:skip_record, if: &(&1.status === "CLOSED"))
end
