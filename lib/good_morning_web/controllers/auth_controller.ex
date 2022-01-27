defmodule GMWeb.AuthController do
  use GMWeb.BaseController
  alias GM.Account.Users

  def login(conn, _params) do
    conn
    |> render(:login,
      login_changeset: %Users{} |> Users.changeset_register(%{})
    )
  end

  def login_post(conn, %{"users" => user_params}) do
    conn
    |> put_flash(:success, "Welcome on Papa Bear admin")
    |> redirect(to: Routes.index_path(conn, :index))
  end
end
