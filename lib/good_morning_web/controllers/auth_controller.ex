defmodule GMWeb.AuthController do
  use GMWeb.BaseController

  alias GM.Account.User
  alias GM.Account.Token
  alias GM.Account.Users

  @max_age 60 * 60 * 24 * 60
  @remember_me_cookie GM.Account.Const.Web.remember_me_cookie()
  @remember_me_options [sign: true, max_age: @max_age, same_site: "Lax"]

  def login(conn, _params) do
    conn
    |> render(:login,
      login_changeset: %Users{} |> Users.changeset_register(%{})
    )
  end

  def login_post(conn, %{"users" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    case User.get_by_email_and_password(email, password) do
      nil ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> render(:login, login_changeset: %Users{} |> Users.changeset_register(user_params))

      user ->
        {:ok, token} = Token.authorization_code(user.id)

        conn
        |> put_flash(:success, "Welcome")
        |> login_user(token.token, user)
        |> redirect(to: Routes.index_path(conn, :index))
    end
  end

  defp login_user(conn, token, %Users{}) do
    conn
    |> renew_session()
    |> put_session(:user_token, token)
    |> put_session(:live_socket_id, "users_sessions:#{Base.url_encode64(token)}")
    |> write_cookies(token)
  end

  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end

  defp write_cookies(conn, token) do
    put_resp_cookie(conn, @remember_me_cookie, token, @remember_me_options)
  end
end
