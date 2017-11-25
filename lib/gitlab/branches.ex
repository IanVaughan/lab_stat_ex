defmodule GitLab.Branches do
  alias GitLab.Projects

  # GET /projects/:id/repository/branches

  @path "/repository/branches/"

  # GitLab.Branches.all("20")
  def all(project_id) do
    Projects.get(project_id, @path)
  end

  # GitLab.Branches.get("20", "DEV-6183-api-orders-not-viewed2")
  def get(project_id, name) do
    Projects.get(project_id, url(name))
  end

  defp url(name), do: @path <> name
end
