defmodule GMWeb.Router do
  use GMWeb, :router

  import GMWeb.PlugController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {GMWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  scope "/", GMWeb do
    pipe_through :browser

    get "/", IndexController, :index
    get "/login", AuthController, :login
    post "/login", AuthController, :login_post
  end

  scope "/user", GMWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", UserController, :index
    get "/:id", UserController, :index
    post "/edit/", UserController, :edit
  end

  scope "/admin", GMWeb do
    pipe_through [:browser, :require_authenticated_admin]

    get "/", AdminController, :index
  end

  scope "/phoenix" do
    import Phoenix.LiveDashboard.Router

    pipe_through [:browser, :require_authenticated_admin]
    live_dashboard "/dashboard", metrics: PBWeb.Telemetry
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
