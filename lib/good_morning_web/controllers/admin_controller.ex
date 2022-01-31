defmodule GMWeb.AdminController do
  use GMWeb.BaseController

  def index(conn, _params) do
    conn |> render(:index)
  end
end
