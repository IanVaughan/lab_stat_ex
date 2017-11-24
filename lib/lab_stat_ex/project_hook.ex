defmodule LabStatEx.ProjectHook do
  use Ecto.Schema

  schema "project_hooks" do
    field :url, :string, null: false
    field :push_events, :boolean
    field :tag_push_events, :boolean
    field :repository_update_events, :boolean
    field :enable_ssl_verification, :boolean
    belongs_to :project, LabStatEx.Project
    field :issues_events, :boolean
    field :merge_requests_events, :boolean
    field :note_events, :boolean
    field :pipeline_events, :boolean
    field :wiki_page_events, :boolean
    field :job_events, :boolean
    timestamps()
  end
end
