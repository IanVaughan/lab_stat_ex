defmodule Workers.Branches do
  import Logger, only: [info: 1]

  def perform(project_id) do
    info "#{__MODULE__} perform:#{project_id}"
    Collectors.Branches.update(project_id)
    |> enqueue_all
  end

  def enqueue_all(items), do: items |> Enum.each(fn(item) -> enqueue(item) end)

  def enqueue(item) do
    {:ok, jid} = Exq.enqueue(Exq, "default",  Workers.Branch, [item.id]) # .name
    info "#{__MODULE__} enqueued:#{jid}"
  end
end
