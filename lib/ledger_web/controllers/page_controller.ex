defmodule LedgerWeb.PageController do
  use LedgerWeb, :controller

  alias Ledger.LogIt
  alias Ledger.CommandedApp

  def index(conn, _params) do
    text(conn, "#{inspect(self())} #{Node.self()}")
  end

  def log_it(conn, %{"id" => id}) do
    command = %LogIt{topic_id: "hi", message: "Message #{id}"}
    CommandedApp.dispatch(command)

    conn
    |> json(%{
      self: inspect(self()),
      node: Node.self()
    })
  end
end
