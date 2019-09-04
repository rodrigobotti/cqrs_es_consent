import Config

config :consent,
  ecto_repos: [Consent.Repo]

config :commanded_ecto_projections,
  repo: Consent.Repo

import_config "#{Mix.env()}.exs"
