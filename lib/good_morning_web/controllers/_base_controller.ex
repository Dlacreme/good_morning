defmodule GMWeb.BaseController do
  defmacro __using__(_) do
    quote do
      use GMWeb, :controller
      import Phoenix.Controller

      @doc """
      Returns the current user or nil if user is not authenticated
      """
      @spec current_user(Plug.Conn.t()) :: GM.Account.Users.t() | nil
      def current_user(conn) do
        conn.assigns[:current_user]
      end
    end
  end
end
