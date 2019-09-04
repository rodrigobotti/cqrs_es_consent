defmodule Consent.Repo do
  use Ecto.Repo,
    otp_app: :consent,
    adapter: Ecto.Adapters.Postgres
end
