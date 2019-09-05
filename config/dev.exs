import Config

config :consent, Consent.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "root",
  password: "admin",
  database: "cqrs_es_readstore",
  hostname: "localhost",
  port: 5433,
  pool_size: 10

config :eventstore,
  column_data_type: "jsonb"

config :eventstore, EventStore.Storage,
  serializer: EventStore.JsonbSerializer,
  types: EventStore.PostgresTypes,
  username: "root",
  password: "admin",
  database: "cqrs_es_eventstore",
  hostname: "localhost",
  port: 5433,
  pool_size: 10
