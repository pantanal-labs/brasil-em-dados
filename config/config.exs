# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :brasil_em_dados,
  ecto_repos: [BrasilEmDados.Repo]

# Configures the endpoint
config :brasil_em_dados, BrasilEmDadosWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8rQCSgpUVzEfveaDKvUVJ/Fa/IFXOM6/xm5nyx+PJkBYN3LRXQe+A+apbTl8lGcs",
  render_errors: [view: BrasilEmDadosWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BrasilEmDados.PubSub,
  live_view: [signing_salt: "7Vfz/VdT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
