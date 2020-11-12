defmodule LedgerWeb.PageController do
  use LedgerWeb, :controller

  def index(conn, _params) do
    text(conn, "#{inspect(self())} #{Node.self()}")
  end
end
