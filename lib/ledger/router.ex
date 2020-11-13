defmodule Ledger.Router do
  use Commanded.Commands.Router

  dispatch(Ledger.LogIt,
    to: Ledger.Topic,
    identity: :topic
  )
end
