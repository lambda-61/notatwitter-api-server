# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :notatwitter,
  ecto_repos: [Notatwitter.Repo]

# Configures the endpoint
config :notatwitter, NotatwitterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zV+6GICF7VWsBFYhpv4SXogjdngh0Mo9sQLnS8LB0Iu3hbxBMaUShoML/O/cxCOJ",
  render_errors: [view: NotatwitterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Notatwitter.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :notatwitter, Notatwitter.Auth.Guardian,
  issuer: "notatwitter",
  secret_key: "wL9B6IPX5iljqxFMnc4kxkL8DTW5QAHLiTvLldaYzZqX43ZEG5vFgimHwCX1SjOT"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
