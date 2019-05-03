# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :top_role,
  ecto_repos: [TopRole.Repo]

# Configures the endpoint
config :top_role, TopRoleWeb.Endpoint,
  url: [
    host: "localhost"
  ],
  secret_key_base: "47ZjkY8RqZd/PDDx8kbumncGmktKkai3qDkmEPA7XtzoxYDcvf9Yap5XPlybWiu0",
  render_errors: [
    view: TopRoleWeb.ErrorView,
    accepts: ~w(html json)
  ],
  pubsub: [
    name: TopRole.PubSub,
    adapter: Phoenix.PubSub.PG2
  ],
  live_view: [
    signing_salt: "ZEfltf7VeRFUdjjL82kbJr0jFK6XhuinkVM54QXdo03TXc1DM2sbh6FHV+hG09IV"
  ]

config :phoenix,
  template_engines: [
    leex: Phoenix.LiveView.Engine
  ]

config :phoenix, :json_library, Jason

config :top_role, :pow,
  user: TopRole.Users.User,
  repo: TopRole.Repo,
  web_module: TopRoleWeb

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
