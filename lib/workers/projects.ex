defmodule Workers.Projects do
  import Logger, only: [info: 1]
  require IEx

  def perform do
    info "#{__MODULE__} perform"
    Collectors.Projects.update()
    |> enqueue_all
  end

  def enqueue_all(items), do: items |> Enum.each(fn(item) -> enqueue(item) end)

  def enqueue(item) do
    IO.inspect item
    IO.inspect item[:id]
    # info "#{__MODULE__} enqueuing:#{item}"
    # {:ok, jid} = Exq.enqueue(Exq, "default",  Workers.Project, [item[:id]])
    # info "#{__MODULE__} enqueued:#{jid}"
  end
end
