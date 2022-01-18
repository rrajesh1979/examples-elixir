defmodule FraudCheck do
  use Opus.Pipeline
  require Logger

  skip(:skip_record, if: &(&1.type != "FRAUDCHK"))
  step(:fraud_check)

  def fraud_check(row) do
    # For simplicity, this function is
    # just a placeholder and does not contain
    # credit check.
    Logger.info("Fraud check for #{row.id}")

    payment_id = row.id

    case payment_id do
      "PAY-004" ->
        raise "Fraud check failed"

      _ ->
        Logger.info("Fraud check passed for #{payment_id}")
    end

    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()

    row_new = %{
      row
      | status: "FRAUDCHK",
        activity_log: Enum.concat(row.activity_log, ["FRAUDCHK"])
    }

    row_new
  end
end
