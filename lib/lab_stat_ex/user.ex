defmodule LabStatEx.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string, null: false
    field :email, :string
    field :deleted_at, :utc_datetime
    timestamps()

    has_many :branches, LabStatEx.Branch
  end

  alias LabStatEx.{Repo, User}

  def save_from_json(user_json) do
    find(user_json[:id])
    |> change(user_json)
    |> Repo.insert_or_update
    # |> return_schema
  end

  defp find(id) do
    case Repo.get(User, id) do
      nil -> %User{}
      user -> user
    end
  end

  def return_schema({:ok, schema}), do: schema
  defp change(user, to), do: Ecto.Changeset.change(user, to)
end
