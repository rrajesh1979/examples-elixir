defmodule RefElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :ref_elixir,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {RefElixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.26.0"},
      {:flow, "~> 1.1"},
      {:nimble_csv, "~> 1.2"},
      {:opus, "~> 0.8"},
      {:opus_graph, "~> 0.1", only: [:dev]},
      {:graphvix, "~> 0.5", only: [:dev]},
      {:telemetry_metrics, "~> 0.6.1"}
    ]
  end
end
