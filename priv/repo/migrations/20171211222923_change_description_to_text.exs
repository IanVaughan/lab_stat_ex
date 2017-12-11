defmodule LabStatEx.Repo.Migrations.ChangeDescriptionToText do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      modify :description, :text
    end
    alter table(:merge_requests) do
      modify :description, :text
    end
  end
end
