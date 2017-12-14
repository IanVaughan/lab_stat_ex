defmodule LabStatEx do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(LabStatEx.Repo, []),
      supervisor(LabStatEx.Endpoint, []),

      worker(GitLab.ResponseDispatcher, []),
      worker(Workers.Projects, []),
      worker(Workers.Branches, []),
      # worker(GitLab.Projects, []),
    ]

    opts = [strategy: :one_for_one, name: LabStatEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    LabStatEx.Endpoint.config_change(changed, removed)
    :ok
  end
end
