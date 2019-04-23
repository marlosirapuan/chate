defmodule ChateWeb.PageController do
  use ChateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
