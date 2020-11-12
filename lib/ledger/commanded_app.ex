defmodule Ledger.CommandedApp do
  use Commanded.Application,
    otp_app: :ledger,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Ledger.EventStore
    ],
    registry: :global

  router(Ledger.Router)
end
