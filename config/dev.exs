import Config

# Configure your database
config :good_morning, GM.Repo,
  username: "postgres",
  password: "postgres",
  database: "good_morning_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
config :good_morning, GMWeb.Endpoint,
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "X/yA1cPEbh84IQRvfCC7P0SIkC2UJ+2cSBYC+7Vu42Qg9z1+VRGDBM+NsJuMuh2e",
  watchers: [
    npm: ["run", "watch", cd: Path.expand("../assets", __DIR__)]
  ]

# Watch static and templates for browser reloading.
config :good_morning, GMWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/good_morning_web/(live|views)/.*(ex)$",
      ~r"lib/good_morning_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
