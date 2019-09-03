import Config

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "eventstore",
  hostname: "localhost",
  pool_size: 10
