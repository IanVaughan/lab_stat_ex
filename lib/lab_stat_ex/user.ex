defmodule LabStatEx.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string, null: false
    field :email, :string
    field :deleted_at, :utc_datetime
    timestamps()

    has_many :branches, LabStatEx.Branch
  end
end
