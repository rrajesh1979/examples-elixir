defmodule PaymentProc do
  require Logger

  import PaymentProc.Utils, only: [get_payments: 0]

  def process do
    Logger.info("#{inspect(__MODULE__)} start processing payments")

    get_payments()
    |> Flow.from_enumerables(max_demand: 10)
    |> Flow.partition(max_demand: 10, stages: 5)
    |> Flow.map(&PaymentPipeline.call/1)
    |> Enum.to_list()

    # |> Enum.to_list()
  end
end
