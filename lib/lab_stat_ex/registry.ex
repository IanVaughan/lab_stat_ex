defmodule LabStatEx.Registry do
  use Ecto.Schema

  schema "registries" do
    field :path, :string, null: false
    field :location, :string
    field :tags_path, :string
    field :destroy_path, :string
    belongs_to :project, LabStatEx.Project
    timestamps()
  end
end
