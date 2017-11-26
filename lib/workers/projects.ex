defmodule Workers.Projects do
  def perform do
    Collectors.Projects.update()
    |> enqueue_all
  end

  def enqueue_all(items) do
    items
    |> Enum.each(fn(item) -> enqueue(item) end)
  end

  def enqueue(item) do
    IO.inspect(item.id)
    {:ok, jid} = Exq.enqueue(Exq, "default",  Workers.Project, [item.id])
    IO.inspect("enqueued:#{jid}")
  end
end
