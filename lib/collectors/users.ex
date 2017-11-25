defmodule Collectors.Users do
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
    |> changeset(user_json)
    |> LabStatEx.Repo.insert_or_update
  end

  defp find_user(id) do
    case LabStatEx.Repo.get(LabStatEx.User, id) do
      nil -> %LabStatEx.User{}
      user -> user
    end
  end

  defp changeset(user, to) do
    Ecto.Changeset.change(user, to)
  end
end
