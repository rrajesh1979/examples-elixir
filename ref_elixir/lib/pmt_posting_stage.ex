defmodule PaymentPosting do
  use Opus.Pipeline
  require Logger

  step(:payment_posting)

  def payment_posting(row) do
    # For simplicity, this function is
    # just a placeholder and does not contain
    # credit check.
    Logger.info("Payment posting for #{row.id}")

    row_new = %{
      row
      | status: "PMT_POSTING_DONE",
        activity_log: Enum.concat(row.activity_log, ["PMT_POSTING_DONE"])
    }

    row_new
  end
end
