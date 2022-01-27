defmodule GM.Repo do
  use Ecto.Repo,
    otp_app: :good_morning,
    adapter: Ecto.Adapters.Postgres
end
