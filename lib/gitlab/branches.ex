defmodule GitLab.Branches do
  import Logger, only: [info: 1]

  alias GitLab.Projects

  # GET /projects/:id/repository/branches

  @path "/repository/branches/"

  def all(project_id, caller_info) do
    Projects.get(project_id, caller_info, @path)
  end

  # GitLab.Branches.get("20", "DEV-6183-api-orders-not-viewed2")
  # def get(project_id, name) do
  #   Projects.get(project_id, url(name))
  # end

  # defp url(name), do: @path <> name
end
