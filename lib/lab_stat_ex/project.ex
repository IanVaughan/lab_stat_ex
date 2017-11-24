defmodule LabStatEx.Project do
  use Ecto.Schema

  schema "projects" do
    field :description, :string
    field :default_branch, :string
    field :tag_list, :string #,  array: true
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
end
