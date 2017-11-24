defmodule LabStatEx.Note do
  use Ecto.Schema

  schema "notes" do
    field :body, :string
    field :attachment, :string
    field :author, :map, default: %{}
    field :system, :boolean
    field :noteable_id, :integer
    field :noteable_type, :string
    field :noteable_iid, :integer
    belongs_to :merge_request, LabStatEx.MergeRequest
    timestamps()
  end
end
