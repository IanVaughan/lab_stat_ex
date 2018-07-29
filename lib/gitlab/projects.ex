defmodule GitLab.Projects do
  @moduledoc """
  Gets information on all or a single GitLab project
  """

  alias GitLab.Base

  # GET /projects/:id

  @path "/projects/"

  def all(caller_info), do: Base.get(@path, caller_info)

  def get(project_id, caller_info, resource \\ "") do
    stringify(project_id)
    |> create_url(resource)
    |> Base.get(caller_info)
  end

  defp stringify(int_or_string) when is_integer(int_or_string), do: Integer.to_string(int_or_string)
  defp stringify(int_or_string), do: int_or_string

  defp create_url(project_id, resource), do: @path <> project_id <> resource
end
