defmodule BrasilEmDados.Repo do
  use Ecto.Repo,
    otp_app: :brasil_em_dados,
    adapter: Ecto.Adapters.Postgres
end
