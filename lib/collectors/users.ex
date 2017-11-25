defmodule Collectors.Users do
  alias LabStatEx.{Repo, User}

  def update() do
    GitLab.Users.all()
    |> save_all
  end

  defp save_all(users) do
    users
    |> Enum.each(fn(a) -> save_one(a) end)
  end

  defp save_one(user_json) do
    find_user(user_json[:id])
    |> change(user_json)
    |> Repo.insert_or_update
  end

  defp find_user(id) do
    case Repo.get(User, id) do
      nil -> %User{}
      user -> user
    end
  end

  defp change(user, to), do: Ecto.Changeset.change(user, to)
end
