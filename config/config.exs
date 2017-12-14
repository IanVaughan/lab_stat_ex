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

config :lab_stat_ex, GitLab.Base,
  api_endpoint: {:system, "GITLAB_API_ENDPOINT"},
  private_token: {:system, "GITLAB_API_PRIVATE_TOKEN"},
  http_adaptor: HTTPoison

config :exq,
  name: Exq,
  # host: "127.0.0.1",
  host: "localhost",
  port: 6379,
  # password: "optional_redis_auth",
  namespace: "lab_stat_ex",
  queues: [{"default", 1}, {"request", 5}],
  poll_timeout: 50,
  scheduler_poll_timeout: 200,
  scheduler_enable: true,
  max_retries: 5
  # shutdown_timeout: 5000

config :exq_ui,
  web_port: 4040,
  web_namespace: "",
  server: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
