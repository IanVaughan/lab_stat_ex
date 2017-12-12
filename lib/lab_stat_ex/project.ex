defmodule LabStatEx.Project do
  use Ecto.Schema
  alias LabStatEx.{Repo, Project}

  schema "projects" do
    field :description, :string
    field :default_branch, :string
    # field :tag_list, :string,  array: true
    field :ssh_url_to_repo, :string
    field :http_url_to_repo, :string
    field :web_url, :string
    field :name, :string #, null: false
    field :name_with_namespace, :string #, null: false
    field :path, :string #, null: false
    field :path_with_namespace, :string #, null: false
    field :star_count, :integer
    field :forks_count, :integer
    field :last_activity_at, :utc_datetime
    field :info, :map , default: %{}
    timestamps()

    has_many :branches, LabStatEx.Branch
    has_many :merge_requests, LabStatEx.MergeRequest
    has_many :project_hooks, LabStatEx.ProjectHook
    has_many :registries, LabStatEx.Registry
  end

  def save_from_json(json) do
    json = timestamp(json)
    find(json[:id])
    |> change(json)
    |> Repo.insert_or_update
    |> return_schema
  end

  defp find(id) do
    case Repo.get_by(Project, id: id) do
      nil -> %Project{}
      rec -> rec
    end
  end

  def return_schema({:ok, schema}), do: schema

  defp change(from, to), do: Ecto.Changeset.change(from, to)

  defp timestamp(json) do
    {:ok, dt, 0} = DateTime.from_iso8601(json[:last_activity_at])
    Keyword.replace(json, :last_activity_at, dt)
  end
end
