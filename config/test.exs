use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lab_stat_ex, LabStatEx.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :info

# Configure your database
config :lab_stat_ex, LabStatEx.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "lab_stat_ex_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
