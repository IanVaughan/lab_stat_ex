defmodule GitLab.MergeRequests do
  alias GitLab.Base

  @path "/merge_requests"

  def get(project_id) do
    Base.get(project_id, url())
  end

  defp url() do
    @path <> "?view=simple"
  end
end
