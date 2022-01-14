defmodule Scrapper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Scrapper.Worker.start_link(arg)
      # {Scrapper.Worker, arg}
      PageProducer,
      Supervisor.child_spec(PageConsumer, id: :consumer_a),
      Supervisor.child_spec(PageConsumer, id: :consumer_b)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scrapper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# Commands
# PageProducer.scrape_pages(pages)
