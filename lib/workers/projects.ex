defmodule Workers.Projects do
  @moduledoc """
  Requests information on all projects, which are then sent back here
  """
  use GenServer

  import Logger, only: [info: 1]
  import GenServer, only: [start_link: 3]

  alias LabStatEx.Project

  # Client

  def start_link, do: start_link(__MODULE__, {}, name: __MODULE__)

  def update, do: GitLab.Projects.all(__MODULE__, :project)

  # Server (callbacks)

  def handle_cast({:project, project}, _state) do
    info "#{__MODULE__} handle_cast:#{project[:id]}"

    Project.save_from_json(project)
    # Workers.Project.update(project[:id])

    {:noreply, []}
  end
end
