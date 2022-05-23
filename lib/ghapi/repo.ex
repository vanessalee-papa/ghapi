defmodule Ghapi.Repo do
  use Ecto.Repo,
    otp_app: :ghapi,
    adapter: Ecto.Adapters.Postgres
end
