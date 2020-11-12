defmodule LedgerWeb.PageControllerTest do
  use LedgerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "Log it", %{conn: conn} do
    topic_id = UUID.uuid4()
    _conn = post(conn, "/api/log_it", %{topic_id: topic_id, message: 1})
  end
end
