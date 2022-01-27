defmodule GMWeb.AuthController do
  use GMWeb.BaseController
  alias GM.Account.Users

  def login(conn, _params) do
    conn
    |> render(:login,
      login_changeset: %Users{} |> Users.changeset_register(%{})
    )
  end
end
