defmodule Consent.MixProject do
  use Mix.Project

  def project do
    [
      app: :consent,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Consent.Application, []},
      extra_applications: [
        :logger,
        :eventstore,
        :timex,
        :ecto_sql
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:timex, "~> 3.5"},
      {:commanded, "~> 0.19"},
      {:jason, "~> 1.1"},
      {:commanded_eventstore_adapter, "~> 0.6"},
      {:commanded_ecto_projections, "~> 0.8"},
      {:ecto, "~> 3.1"},
      {:ecto_sql, "~> 3.1"}
    ]
  end

  defp aliases do
    [
      setup_es: ["event_store.create", "event_store.init"],
      setup_ecto: ["ecto.create", "ecto.migrate"],
      setup_db: ["setup_es", "setup_ecto"],
      drop_db: ["ecto.drop", "event_store.drop"],
      reset_db: ["drop_db", "setup_db"],
      test: ["reset_db", "test --trace"]
    ]
  end
end
