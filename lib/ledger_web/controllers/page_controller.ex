defmodule LedgerWeb.PageController do
  use LedgerWeb, :controller
  import Ecto.Query

  alias Ledger.LogIt
  alias Ledger.CommandedApp
  alias Ledger.Repo

  def index(conn, _params) do
    text(conn, "#{inspect(self())} #{Node.self()}")
  end

  def log_it(conn, %{"topic" => topic, "message" => message}) do
    command = %LogIt{topic: topic, message: message}
    :ok = CommandedApp.dispatch(command)

    conn
    |> json(%{
      topic: topic,
      message: message,
      self: inspect(self()),
      node: Node.self()
    })
  end

  def messages(conn, _params) do
    query =
      Ledger.HandledMessage
      |> order_by(desc: :inserted_at)

    messages = Repo.all(query)

    conn
    |> render("messages.html", messages: messages)
  end
end
