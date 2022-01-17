defmodule PaymentPipeline do
  use Opus.Pipeline

  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  step(:parse_row)
  step(:credit_check, if: &(&1.status != "CLOSED"))
  step(:fraud_check)
  step(:payment_posting)
  step(:cleanup)

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

  def credit_check(row) do
    # For simplicity, this function is
    # just a placeholder and does not contain
    # credit check.
    Logger.info("Credit check for #{row.id}")

    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()

    row_new = %{
      row
      | status: "CREDIT_CHECKED",
        activity_log: Enum.concat(row.activity_log, ["CREDIT_CHECKED"])
    }

    row_new
  end

  def fraud_check(row) do
    # For simplicity, this function is
    # just a placeholder and does not contain
    # credit check.
    Logger.info("Fraud check for #{row.id}")

    row_new = %{
      row
      | status: "FRAUD_CHK_DONE",
        activity_log: Enum.concat(row.activity_log, ["FRAUD_CHK_DONE"])
    }

    row_new
  end

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

  def cleanup(row) do
    # For simplicity, this function is
    # just a placeholder and does not contain
    # credit check.
    Logger.info("Post processing cleanup for #{row.id}")

    row_new = %{
      row
      | status: "PROCESSING_DONE",
        activity_log: Enum.concat(row.activity_log, ["CLEANUP_DONE"])
    }

    row_new
  end
end

#
