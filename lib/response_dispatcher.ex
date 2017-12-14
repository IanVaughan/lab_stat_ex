defmodule GitLab.ResponseDispatcher do
  @moduledoc """
  Receives a list of response objects from an API call
  and sends them one by one to the provided caller
  """
  use GenServer

  import GenServer, only: [start_link: 3, cast: 2]
  import Logger, only: [info: 1]

  # Client

  def start_link, do: start_link(__MODULE__, {}, name: __MODULE__)

  @doc "Send the data the the genserver for processing"
  # @spec send(list(), tuple()) :: :ok
  def send(items, caller, name), do: cast(:send_all, {items, caller, name})

  # Server (callbacks)

  def handle_cast({:send_all, items, caller, name}, _state) do
    send_all(items, caller, name)
    {:noreply, []}
  end

  defp send_all(items, caller, name), do: items |> Enum.each(fn(item) -> send_one(item, caller, name) end)

  defp send_one(item, caller, name) do
    info "#{__MODULE__} sending:#{item[:id]} to #{caller}, #{name}"
    caller
    |> String.to_existing_atom
    # |> GenServer.cast({name, item})
  end
end
