defmodule Workers.Project do
  def perform(project_id) do
    IO.inspect("Workers.Project:#{project_id}")
  end
end
