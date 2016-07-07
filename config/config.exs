# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :karaoke, Karaoke.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "kNWTu7+SmuS8oLyx98zuQQvXNx8wuODCKY0bUIq8CyvJ6OI1M8eJEpVS3xvF9CwA",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: Karaoke.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :karaoke,
  musicgraph_tracks: "http://api.musicgraph.com/api/v2/track/search"

import_config "api_key.exs"
