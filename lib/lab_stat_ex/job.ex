defmodule LabStatEx.Job do
  use Ecto.Schema

  schema "jobs" do
    field :status, :string #, null: false
    field :stage, :string #, null: false
    field :name, :string #, null: false
    field :ref, :string #, null: false
    field :tag, :string #, null: false
    field :coverage, :string
    field :started_at, :utc_datetime
    field :finished_at, :utc_datetime
    field :user, :map, default: %{}
    field :commit, :map, default: %{}
    field :runner, :map, default: %{}
    field :pipeline, :map, default: %{}
    # belongs_to :pipeline, LabStatEx.Pipeline
    field :trace, :string
    timestamps()
  end
end
