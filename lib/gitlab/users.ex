defmodule GitLab.Users do
  alias GitLab.Base

  # GET /users

  @path "/users"

  def all(), do: Base.get(@path)
end
