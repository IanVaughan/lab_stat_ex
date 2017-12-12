defmodule LabStatEx.Branch do
  use Ecto.Schema

  schema "branches" do
    field :name, :string #, null: false
    field :commit, :map
    field :merged, :boolean
    field :protected, :boolean
    field :developers_can_push, :boolean
    field :developers_can_merge, :boolean
    belongs_to :project, LabStatEx.Project
    field :recorded_old_at, :utc_datetime
    field :notified_old_at, :utc_datetime
    belongs_to :user, LabStatEx.User
    field :deleted_at, :utc_datetime
    field :delete_reason, :string
    timestamps()
  end

  alias LabStatEx.{Repo, Branch}

  defp save_from_json(json, project_id) do
    find(json[:name], project_id)
    |> change(json)
    |> Repo.insert_or_update
    |> return_schema
  end

  def return_schema({:ok, schema}), do: schema

  defp find(name, project_id) do
    case Repo.get_by(Branch, name: name, project_id: project_id) do
      nil -> %Branch{}
      rec -> rec
    end
  end

  defp change(from, to), do: Ecto.Changeset.change(from, to)
end
