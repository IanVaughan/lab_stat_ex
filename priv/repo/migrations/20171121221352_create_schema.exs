defmodule LabStatEx.Repo.Migrations.CreateSchema do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :description, :string
      add :default_branch, :string
      add :tag_list, :string,  array: true
      add :ssh_url_to_repo, :string
      add :http_url_to_repo, :string
      add :web_url, :string
      add :name, :string, null: false
      add :name_with_namespace, :string, null: false
      add :path, :string, null: false
      add :path_with_namespace, :string, null: false
      add :star_count, :integer
      add :forks_count, :integer
      add :last_activity_at, :utc_datetime
      add :info, :map , default: %{}
      add :deleted_at, :utc_datetime
      timestamps()
    end

    create table(:users) do
      add :name, :string, null: false
      add :email, :string
      add :deleted_at, :utc_datetime
      timestamps()
    end

    create table(:branches) do
      add :name, :string, null: false
      add :commit, :map
      add :merged, :boolean
      add :protected, :boolean
      add :developers_can_push, :boolean
      add :developers_can_merge, :boolean
      add :project_id, references(:projects)
      add :recorded_old_at, :utc_datetime
      add :notified_old_at, :utc_datetime
      add :user_id, references(:users)
      add :deleted_at, :utc_datetime
      add :delete_reason, :string
      timestamps()
    end
    create index(:branches, [:project_id])

    create table(:images) do
      add :name, :string , null: false
      add :location, :string
      add :revision, :string
      add :short_revision, :string
      add :total_size, :string
      add :created_at, :string
      add :destroy_path, :string
      add :registry_id, :integer
      add :deleted_at, :utc_datetime
      timestamps()
    end
    create index(:images, [:registry_id])

    create table(:pipelines) do
      add :sha, :string,   null: false
      add :ref, :string,   null: false
      add :status, :string, null: false
      add :info, :map, default: "{}"
      add :project_id, references(:projects)
      timestamps()
    end
    create index(:pipelines, [:project_id])

    create table(:jobs) do
      add :status, :string, null: false
      add :stage, :string, null: false
      add :name, :string, null: false
      add :ref, :string, null: false
      add :tag, :string, null: false
      add :coverage, :string
      add :started_at, :utc_datetime
      add :finished_at, :utc_datetime
      add :user, :map, default: "{}"
      add :commit, :map, default: "{}"
      add :runner, :map, default: "{}"
      add :pipeline, :map, default: "{}"
      add :pipeline_id, references(:pipelines)
      add :trace, :string
      timestamps()
    end
    create index(:jobs, [:pipeline_id])

    create table(:merge_requests) do
      add :iid, :integer, null: false
      add :title, :string,  null: false
      add :description, :string
      add :state, :string,  null: false
      add :web_url, :string, null: false
      add :project_id, references(:projects)
      add :info, :map, default: "{}"

      timestamps()
    end
    create index(:merge_requests, [:project_id])

    create table(:notes) do
      add :body, :string
      add :attachment, :string
      add :author, :map, default: "{}"
      add :system, :boolean
      add :noteable_id, :integer
      add :noteable_type, :string
      add :noteable_iid, :integer
      add :merge_request_id, references(:merge_requests)
      timestamps()
    end
    create index(:notes, [:merge_request_id])

    create table(:project_hooks) do
      add :url, :string,    null: false
      add :push_events, :boolean
      add :tag_push_events, :boolean
      add :repository_update_events, :boolean
      add :enable_ssl_verification, :boolean
      add :project_id, references(:projects)
      add :issues_events, :boolean
      add :merge_requests_events, :boolean
      add :note_events, :boolean
      add :pipeline_events, :boolean
      add :wiki_page_events, :boolean
      add :job_events, :boolean
      timestamps()
    end
    create index(:project_hooks, [:project_id])

    create table(:registries) do
      add :path, :string, null: false
      add :location, :string
      add :tags_path, :string
      add :destroy_path, :string
      add :project_id, references(:projects)
      timestamps()
    end
    create index(:registries, [:project_id])

    create table(:system_hooks) do
      add :url, :string, null: false
      add :push_events, :boolean
      add :tag_push_events, :boolean
      add :repository_update_events, :boolean
      add :enable_ssl_verification, :boolean
      timestamps()
    end
  end
end
