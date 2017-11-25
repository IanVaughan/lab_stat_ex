defmodule GitLab.MergeRequests do
  alias GitLab.Projects

  # GET /projects/:id/merge_requests

  @path "/merge_requests"

  def get(project_id) do
    Projects.get(project_id, url())
  end

  defp url(), do: @path <> "?view=simple"
end
