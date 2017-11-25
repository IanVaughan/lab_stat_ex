defmodule GitLab.Projects do
  alias GitLab.Base

  # GET /projects/:id

  @path "/projects/"

  def all() do
    Base.get(@path)
  end

  def get(project_id, resource \\ "") do
    stringify(project_id)
    |> create_url(resource)
    |> Base.get
  end

  defp stringify(int_or_string) when is_integer(int_or_string), do: Integer.to_string(int_or_string)
  defp stringify(int_or_string), do: int_or_string

  defp create_url(project_id, resource), do: @path <> project_id <> resource
end
