defmodule Collectors.Projects do
  alias LabStatEx.{Repo, Project}

  def update() do
    GitLab.Projects.all
    |> save_all
  end

  defp save_all(items), do: Enum.map(items, fn(item) -> save_one(item) end)

  defp save_one(json) do
    json = timestamp(json)
    find(json[:id])
    |> change(json)
    |> Repo.insert_or_update
    |> return_schema
  end

  def return_schema({:ok, schema}), do: schema

  defp find(id) do
    case Repo.get_by(Project, id: id) do
      nil -> %Project{}
      rec -> rec
    end
  end

  defp change(from, to), do: Ecto.Changeset.change(from, to)

  defp timestamp(json) do
    {:ok, dt, 0} = DateTime.from_iso8601(json[:last_activity_at])
    Keyword.replace(json, :last_activity_at, dt)
  end
end
