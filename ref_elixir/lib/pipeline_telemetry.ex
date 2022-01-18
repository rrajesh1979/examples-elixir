defmodule CustomInstrumentation do
  require Logger

  def instrument(:pipeline_started, %{pipeline: pipeline}, %{input: _input}) do
    :telemetry.execute(
      [:opus, :pipeline, :start],
      %{time: System.system_time()},
      %{pipeline: inspect(pipeline)}
    )
  end

  def instrument(:stage_completed, %{stage: %{name: name, pipeline: pipeline}}, %{time: time}) do
    :telemetry.execute(
      [:opus, :pipeline, :stage, :stop],
      %{duration: time},
      %{pipeline: inspect(pipeline), stage: name}
    )
  end

  def instrument(:pipeline_completed, %{pipeline: pipeline}, %{result: {:ok, _}, time: time}) do
    emit_stop(%{pipeline: pipeline, success?: true, duration: time})
  end

  def instrument(:pipeline_completed, %{pipeline: pipeline}, %{result: {:error, _}, time: time}) do
    emit_stop(%{pipeline: pipeline, success?: false, duration: time})
  end

  def instrument(_event, _, _) do
    :ok
  end

  defp emit_stop(%{pipeline: pipeline, success?: success?, duration: duration}) do
    :telemetry.execute(
      [:opus, :pipeline, :stop],
      %{duration: duration, success: success?},
      %{pipeline: inspect(pipeline)}
    )
  end
end
