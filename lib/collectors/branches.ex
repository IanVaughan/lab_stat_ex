defmodule Collectors.Branches do
  alias LabStatEx.{Repo, Branch}

  def update(project_id) do
    GitLab.Branches.all(project_id)
    |> save_all(project_id)
  end

  defp save_all(items, project_id), do: Enum.each(items, fn(a) -> save_one(a, project_id) end)

  defp save_one(json, project_id) do
    find(json[:name], project_id)
    |> change(json)
    |> Repo.insert_or_update
  end

  defp find(name, project_id) do
    case Repo.get_by(Branch, name: name, project_id: project_id) do
      nil -> %Branch{}
      rec -> rec
    end
  end

  defp change(from, to), do: Ecto.Changeset.change(from, to)
end
