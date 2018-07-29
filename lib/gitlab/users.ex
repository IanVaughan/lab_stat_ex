defmodule GitLab.Users do
  alias GitLab.Base

  # GET /users

  @path "/users/"

  def all(caller_info), do: Base.get(@path, caller_info)
  def get(id), do: Base.get(@path <> id)

  # def update() do
  #   GitLab.Users.all()
  #   |> save_all
  # end
  #
  # defp save_all(users) do
  #   users
  #   |> Enum.each(fn(a) -> save_one(a) end)
  # end
end
