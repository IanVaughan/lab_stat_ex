defmodule LabStatEx.Image do
  use Ecto.Schema

  schema "images" do
    field :name, :string #, null: false
    field :location, :string
    field :revision, :string
    field :short_revision, :string
    field :total_size, :string
    field :created_at, :string
    field :destroy_path, :string
    field :registry_id, :integer
    field :deleted_at, :utc_datetime
    timestamps()
  end
end
