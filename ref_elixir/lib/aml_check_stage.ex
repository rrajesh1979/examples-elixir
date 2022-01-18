defmodule AMLCheck do
  use Opus.Pipeline
  require Logger

  skip(:skip_record, if: &(&1.type != "FRAUDCHK"))
  step(:aml_check)

  def aml_check(row) do
    # For simplicity, this function is
    # just a placeholder and does not contain
    # credit check.
    Logger.info("AML check for #{row.id}")

    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()

    row_new = %{
      row
      | status: "AMLCHK",
        activity_log: Enum.concat(row.activity_log, ["AMLCHK"])
    }

    row_new
  end
end
