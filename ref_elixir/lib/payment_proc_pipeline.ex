defmodule PaymentProc.Pipeline do
  # use GenStage
  require Logger

  import PaymentProc.Utils, only: [get_payments: 0, parse_row: 1, filter_data: 1]
  import PaymentAPI.Worker, only: [credit_check: 1]

  @moduledoc """
  This module is used to process payments.

  ## Examples

      iex> PaymentProc.Pipeline.process()
      :world

  """

  def process do
    Logger.info("#{inspect(__MODULE__)} start processing payments")

    get_payments()
    |> Flow.from_enumerables(max_demand: 10)
    |> Flow.partition(max_demand: 10, stages: 5)
    |> Flow.map(&parse_row/1)
    |> Flow.reject(&filter_data/1)
    |> Flow.map(&credit_check/1)
    |> Enum.to_list()
  end
end

# Commands
# PaymentProc.Pipeline.process()
