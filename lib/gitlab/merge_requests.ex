defmodule GitLab.MergeRequests do
  alias GitLab.Project.Base

  # GET /projects/:id/merge_requests

  @path "/merge_requests"

  def get(project_id) do
    Base.project(project_id, url())
  end

  defp url(), do: @path <> "?view=simple"
end
