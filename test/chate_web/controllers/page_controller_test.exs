defmodule ChateWeb.PageControllerTest do
  use ChateWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "chat-messages"
  end
end
