defmodule Ledger.Projector do
  use Commanded.Projections.Ecto,
    application: Ledger.CommandedApp,
    repo: Ledger.Repo,
    name: "Ledger.Projector"

  alias Ecto.Multi
  alias Ledger.HandledMessage

  project(%Ledger.LoggedIt{} = event, metadata, fn multi ->
    multi
    |> Multi.insert(:ledge_projector, %HandledMessage{
      topic: event.topic,
      message: event.message,
      handled_by_node: inspect(Node.self()),
      handled_by_pid: inspect(self()),
      received_by_node: event.received_by_node,
      received_by_pid: event.received_by_pid
    })
  end)
end
