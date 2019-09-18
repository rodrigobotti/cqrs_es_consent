# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :consent,
  ecto_repos: [Consent.Repo]

# Configures the endpoint
config :consent, ConsentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m+ulHTdegkOsjV4ry9iQx1hwFnSC84bjgbYPGj/GJinuRquc1lKPVLikow2RRb4n",
  render_errors: [view: ConsentWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Consent.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Commanded projections
config :commanded_ecto_projections,
  repo: Consent.Repo

# Commanded default consistency mode
config :commanded, default_consistency: :strong

# commanded eventstore
config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
