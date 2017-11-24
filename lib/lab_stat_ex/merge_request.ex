defmodule LabStatEx.MergeRequest do
  use Ecto.Schema

  schema "merge_requests" do
    field :iid, :integer, null: false
    field :title, :string,  null: false
    field :description, :string
    field :state, :string,  null: false
    field :web_url, :string, null: false
    belongs_to :project, LabStatEx.Project
    field :info, :map, default: %{}
    timestamps()

    has_many :notes,LabStatEx.Note
  end
end
