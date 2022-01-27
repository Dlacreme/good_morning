defmodule GMWeb.PageController do
  use GMWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
