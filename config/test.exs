import Config

config :consent, Consent.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "root",
  password: "admin",
  database: "consent_test",
  hostname: "localhost",
  port: 5433,
  pool_size: 10

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.InMemory

config :commanded, Commanded.EventStore.Adapters.InMemory,
  serializer: Commanded.Serialization.JsonSerializer

config :ex_unit, capture_log: true
