defmodule PostProcessing do
  use Opus.Pipeline
  require Logger

  step(:post_processing)

  def post_processing(row) do
    # For simplicity, this function is
    # just a placeholder and does not contain
    # credit check.
    Logger.info("Post processing for #{row.id}")

    row_new = %{
      row
      | status: "POST_PROC_DONE",
        activity_log: Enum.concat(row.activity_log, ["POST_PROC_DONE"])
    }

    row_new
  end
end
