defmodule Workers.Branches do
  use GenServer

  import GenServer, only: [start_link: 3]
  import Logger, only: [info: 1]

  # Client

  def start_link, do: start_link(__MODULE__, {}, name: __MODULE__)

  @doc """
  Public method to enqueue a worker to fetch and save of all
  branches for the given project id
  """
  def update(project_id) do
    {:ok, jid} = Exq.enqueue(Exq, "default",  Workers.Branches, [project_id])
    info "#{__MODULE__} enqueued:#{jid}"
  end

  @doc """
  Worker to
  """
  def perform(project_id) do
    info "#{__MODULE__} perform:#{project_id}"
    GitLab.Branches.all(__MODULE__, project_id)
  end

  # Server (callbacks)

  def handle_cast({:branch, branch}, _state) do
    info "#{__MODULE__} handle_cast:#{branch[:name]}"

    # Branch.save_from_json(branch)
    # Workers.Project.update(project[:id])

    {:noreply, []}
  end

  # Server (callbacks)

  def handle_cast({:project, project}, _state) do
    info "#{__MODULE__} handle_cast:#{project[:id]}"

    Project.save_from_json(project)
    Workers.Project.update(project[:id])

    {:noreply, []}
  end

  defp enqueue_all(items), do: items |> Enum.each(fn(item) -> enqueue(item) end)

  defp enqueue(item) do
    {:ok, jid} = Exq.enqueue(Exq, "default",  Workers.Branch, [item.id]) # .name
    info "#{__MODULE__} enqueued:#{jid}"
  end
end
