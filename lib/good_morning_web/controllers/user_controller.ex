defmodule GMWeb.UserController do
  use GMWeb.BaseController

  def profile(%{assigns: %{current_user: current_user}} = conn, _params) do
    IO.puts(" CURRENT USER > #{inspect(current_user)}")
    conn |> render(:profile)
  end
end
