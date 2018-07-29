defmodule Workers.Users do
  @moduledoc """
  """
  use GenServer

  import Logger, only: [info: 1]
  import GenServer, only: [start_link: 3]

  alias LabStatEx.User

  # Client

  def start_link, do: start_link(__MODULE__, {}, name: __MODULE__)

  def update, do: GitLab.Users.all(%{callback: __MODULE__, key: :user})

  # Server (callbacks)

  def handle_cast({:user, user_json, _id}, _state) do
    info "#{__MODULE__} handle_cast:#{user_json[:id]}"

    User.save_from_json(user_json)

    {:noreply, []}
  end
end
