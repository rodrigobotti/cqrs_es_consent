import Config

config :consent, ecto_repos: [Consent.Repo]

import_config "#{Mix.env()}.exs"
