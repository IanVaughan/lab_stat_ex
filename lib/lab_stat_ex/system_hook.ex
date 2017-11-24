defmodule LabStatEx.SystemHook do
  use Ecto.Schema

  schema "system_hooks" do
    field :url, :string, null: false
    field :push_events, :boolean
    field :tag_push_events, :boolean
    field :repository_update_events, :boolean
    field :enable_ssl_verification, :boolean
    timestamps()
  end
end
