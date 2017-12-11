defmodule Workers.Project do
  import Logger, only: [info: 1]

  def perform(project_id) do
    info "#{__MODULE__} perform:#{project_id}"
    # {:ok, jid} = Exq.enqueue(Exq, "default",  Workers.Branches, [project_id])
    # info "#{__MODULE__} enqueued:#{jid}"
  end
end
