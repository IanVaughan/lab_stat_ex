defmodule GitLab.Users do
  alias GitLab.Base

  # GET /users

  @path "/users/"

  def all(), do: Base.get(@path)
  def get(id), do: Base.get(@path <> id)
end
