import Config

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "root",
  password: "admin",
  database: "cqrs_es_eventstore",
  hostname: "localhost",
  port: 5433,
  pool_size: 10
