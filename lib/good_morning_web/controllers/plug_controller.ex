defmodule GMWeb.PlugController do
  @moduledoc """
  Provide plugs to handle auth
  """

  require Logger
  use GMWeb.BaseController
  alias GM.Account.User
  alias GM.Account.Token
  alias GM.Account.Tokens

  @remember_me_cookie GM.Account.Const.Web.remember_me_cookie()

  def fetch_current_user(conn, _opts) do
    {token, conn} = retrieve_token(conn)

    if token != nil do
      with token_instance = %Tokens{} <- Token.get_by_token(token),
           {:ok, user} <- fetch_user(token_instance.user_id) do
        assign(conn, :current_user, user)
      else
        _ -> assign(conn, :current_user, nil)
      end
    else
      assign(conn, :current_user, nil)
    end
  end

  def require_authenticated_user(conn, _opts) do
    require_authenticate_type(conn, [
      GM.Account.Const.UserType.user(),
      GM.Account.Const.UserType.admin()
    ])
  end

  def require_authenticated_admin(conn, _opts) do
    require_authenticate_type(conn, [GM.Account.Const.UserType.admin()])
  end

  defp require_authenticate_type(conn, type) do
    if Map.has_key?(conn.assigns, :current_user) && Map.fetch!(conn.assigns, :current_user) != nil do
      user = Map.fetch!(conn.assigns, :current_user)

      if user.type_id in type do
        conn
      else
        conn
        |> not_found()
      end
    else
      conn
      |> not_found()
    end
  end

  defp not_found(conn) do
    conn
    |> put_view(GMWeb.ErrorView)
    |> render("404.html")
    |> halt()
  end

  defp fetch_user(user_id) do
    case User.get(user_id) do
      nil -> {:error, nil}
      user -> {:ok, user}
    end
  end

  defp retrieve_token(conn) do
    if user_token = get_session(conn, :user_token) do
      {user_token, conn}
    else
      conn = fetch_cookies(conn, signed: [@remember_me_cookie])

      if user_token = conn.cookies[@remember_me_cookie] do
        {user_token, put_session(conn, :user_token, user_token)}
      else
        {nil, conn}
      end
    end
  end
end
