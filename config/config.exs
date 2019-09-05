import Config

config :consent,
  ecto_repos: [Consent.Repo]

config :commanded_ecto_projections,
  repo: Consent.Repo

config :commanded, default_consistency: :strong

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

import_config "#{Mix.env()}.exs"
