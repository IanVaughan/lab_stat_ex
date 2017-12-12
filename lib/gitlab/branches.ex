defmodule GitLab.Branches do
  use GenServer

  import Logger, only: [info: 1]
  import GenServer, only: [start_link: 3, cast: 2]

  alias GitLab.Projects

  # GET /projects/:id/repository/branches

  @path "/repository/branches/"

  # Client

  def start_link, do: start_link(__MODULE__, {}, name: __MODULE__)

  def all_cast(pid, project_id) do
    cast(__MODULE__, {:branches, project_id, pid})
  end

  # GitLab.Branches.get("20", "DEV-6183-api-orders-not-viewed2")
  def get(project_id, name) do
    Projects.get(project_id, url(name))
  end

  # Server (callbacks)

  def handle_cast({:branches, project_id, pid}, _state) do
    info "#{__MODULE__} handle_cast"

    Projects.get(project_id, @path)
    |> send_each(pid)

    {:noreply, []}
  end

  defp send_each(items, pid), do: items |> Enum.each(fn(item) -> send_one(item, pid) end)

  defp send_one(branch, pid) do
    info "#{__MODULE__} sending:#{branch[:name]}"
    # GenServer.cast(pid, {:branch, branch})
  end

  defp url(name), do: @path <> name
end
