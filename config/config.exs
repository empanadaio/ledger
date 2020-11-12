# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ledger,
  ecto_repos: [Ledger.Repo],
  generators: [binary_id: true]

config :ledger, Ledger.Application,
  pubsub: [
    phoenix_pubsub: [
      adapter: Phoenix.PubSub.PG2,
      pool_size: 1
    ]
  ]

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :eventstore, EventStore.Storage, serializer: EventStore.JsonbSerializer

config :ledger, event_stores: [Ledger.EventStore]

# Configures the endpoint
config :ledger, LedgerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "l7r4YRGOG7UUUwxXmuWgfWkXM68h6O2taSMZ/Act2BpW1wCMCZTU/L6xN03Dwkke",
  render_errors: [view: LedgerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ledger.PubSub,
  live_view: [signing_salt: "QsoHkkta"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
