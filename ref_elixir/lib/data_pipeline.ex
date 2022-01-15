defmodule Data.Pipeline do
  @spec get_payment :: Stream
  def get_payment do
    1..5
  end

  def hello do
    :world

    get_payment()
    |> Flow.from_enumerable()
    |> Enum.to_list()
  end
end
