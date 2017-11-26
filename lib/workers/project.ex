defmodule Workers.Project do
  import Logger, only: [info: 1]

  def perform(project_id) do
    info "#{__MODULE__} perform:#{project_id}"
  end
end
