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
end
