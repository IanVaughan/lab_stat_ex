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
  def send(items, caller_info) when is_list(items), do: cast(__MODULE__, {:send_all, items, caller_info})
  def send(items, caller_info), do: cast(__MODULE__, {:send_one, items, caller_info})

  # Server (callbacks)

  def handle_cast({:send_all, items, caller_info}, _state) do
    info "#{__MODULE__} handle_cast"
    send_all(items, caller_info)
    {:noreply, []}
  end

  def handle_cast({:send_one, item, caller_info}, _state) do
    info "#{__MODULE__} handle_cast"
    send_one(item, caller_info)
    {:noreply, []}
  end

  defp send_all(nil, _caller_name), do: info "#{__MODULE__} send_all nil"
  defp send_all(:ok, _caller_name), do: info "#{__MODULE__} send_all ok"
  defp send_all(items, caller_info), do: items |> Enum.each(fn(item) -> send_one(item, caller_info) end)

  defp send_one(item, caller_info) do
    info "#{__MODULE__} send_one"

    caller = caller_info["callback"]
    key = caller_info["key"]
    id = caller_info["id"]

    key_atom = String.to_existing_atom(key)

    String.to_existing_atom(caller)
    |> cast({key_atom, item, id})
  end
end
