defmodule CreditCheck do
  use Opus.Pipeline
  require Logger

  skip(:skip_record, if: &(&1.type != "CREDITCHK"))
  step(:credit_check)

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
end
