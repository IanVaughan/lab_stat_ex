defmodule GitLab.Projects do
  @moduledoc """
  Gets information on all or a single GitLab project
  """
  # use GenServer

  import Logger, only: [info: 1]
  # import GenServer, only: [start_link: 3, cast: 2]

  alias GitLab.Base

  # GET /projects/:id

  @path "/projects/"

  # Client

  # def start_link, do: start_link(__MODULE__, {}, name: __MODULE__)

  # def all(pid), do: cast(__MODULE__, {:projects, pid})
  def all(caller, name), do: Base.get(@path, caller, name)

  # def get(project_id, resource \\ "") do
  #   stringify(project_id)
  #   |> create_url(resource)
  #   |> Base.get
  # end

  # Server (callbacks)

  # def handle_cast({:projects, pid}, _state) do
  #   info "#{__MODULE__} handle_cast"
  #
  #   Base.get(@path)
  #   |> send_each(pid)
  #
  #   {:noreply, []}
  # end

  # defp send_each(items, pid), do: items |> Enum.each(fn(item) -> send_one(item, pid) end)
  #
  # defp send_one(project, pid) do
  #   info "#{__MODULE__} sending:#{project[:id]}"
  #   GenServer.cast(pid, {:project, project})
  # end

  # defp stringify(int_or_string) when is_integer(int_or_string), do: Integer.to_string(int_or_string)
  # defp stringify(int_or_string), do: int_or_string
  #
  # defp create_url(project_id, resource), do: @path <> project_id <> resource
end
