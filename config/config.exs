import Config

config :good_morning,
  namespace: GM,
  ecto_repos: [GM.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :good_morning, GMWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: GMWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GM.PubSub,
  live_view: [signing_salt: "k6f+64S2"]

config :good_morning, GM.Mailer, adapter: Swoosh.Adapters.Local

# Crypt signer for Joken
config :joken, default_signer: "k5DnOxzTC9mBKQrwPL6QahRapSGQaJQkWNtCNOLq2ZwVXuNNVMOKfVurZkkquxaC"

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild, version: "0.13.5"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
