defmodule PaymentAPI.Worker do
  require Logger

  def credit_check(row) do
    # For simplicity, this function is
    # just a placeholder and does not contain
    # credit check.
    Logger.info("Credit check for #{row.id}")

    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()
  end
end
