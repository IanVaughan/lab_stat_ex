defmodule Workers.Project do
  @moduledoc """
  Any per-project checks can be done in here
  """
  import Logger, only: [info: 1]

  def update(project_id) do
    {:ok, jid} = Exq.enqueue(Exq, "default",  Workers.Project, [project_id])
    info "#{__MODULE__} enqueued:#{jid}"
  end

  def perform(project_id) do
    info "#{__MODULE__} perform:#{project_id}"
    Workers.Branches.update(project_id)
  end
end
