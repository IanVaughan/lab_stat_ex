# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lab_stat_ex,
  ecto_repos: [LabStatEx.Repo]

# Configures the endpoint
config :lab_stat_ex, LabStatEx.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "09IA64Wzjldo31pOG2Rrk47o8SRNw5CJW+NqD6GCgdi0ioGGvSQAq1BVtlZ2QZRA",
  render_errors: [view: LabStatEx.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LabStatEx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"