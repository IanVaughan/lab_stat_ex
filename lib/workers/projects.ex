defmodule Workers.Projects do
  @moduledoc """
  Requests information on all projects, which are then sent back here

  Workers.Projects.update
  """
  use GenServer

  import Logger, only: [info: 1]
  import GenServer, only: [start_link: 3]

  alias LabStatEx.Project

  # Client

  def start_link, do: start_link(__MODULE__, {}, name: __MODULE__)

  def update, do: GitLab.Projects.all(%{callback: __MODULE__, key: :project})

  # Server (callbacks)

  def handle_cast({:project, project, _id}, _state) do
    info "#{__MODULE__} handle_cast:#{project[:id]}"

    Project.save_from_json(project)
    Workers.Project.update(project[:id])

    {:noreply, []}
  end
end
