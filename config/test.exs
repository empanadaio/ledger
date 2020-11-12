use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ledger, Ledger.Repo,
  username: "postgres",
  password: "postgres",
  database: "ledger_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  port: 5410,
  pool: Ecto.Adapters.SQL.Sandbox

config :ledger, Ledger.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "ledger_test",
  hostname: "localhost",
  port: 5410,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  schema: "eventstore"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ledger, LedgerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
