defmodule GMWeb.UserController do
  use GMWeb.BaseController
  alias GM.Account.Users

  def index(%{assigns: %{current_user: %{id: c_id}}} = conn, %{"id" => id})
      when id != c_id do
    user_profile(conn, GM.Account.User.get(id), false)
  end

  def index(%{assigns: %{current_user: current_user}} = conn, _params) do
    user_profile(conn, current_user, true)
  end

  def edit(conn, params) do
    IO.puts("SUBMIT > #{inspect(params)}")
    conn |> redirect(to: Routes.user_path(conn, :index))
  end

  defp user_profile(conn, user, false) do
    conn
    |> render(:display, user: user)
  end

  defp user_profile(conn, user, true) do
    conn
    |> render(:edit, user: user, changeset: Users.changeset_register(user, %{}))
  end
end
