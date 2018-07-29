defmodule GitLab.Base do
  @moduledoc """
  Base module for using GitLab API
  Pushes requests into a worker queue (which acts as a pool), to limit number
  of requests active at any point in time.
  Can recurse paginated result sets obtaining the complete dataset.

  It casts each element of the result set back to the caller via ResponseDispatcher
  """
  use Confex, otp_app: :lab_stat_ex

  import Logger, only: [info: 1]

  @api_version "/api/v4"
  @max_retries 5

  # Client

  def get(resource, caller_info, recurse \\ true) do
    info "#{__MODULE__} enqueuing:#{resource}"
    {:ok, jid} = Exq.enqueue(Exq, "request",  GitLab.Base, [resource, caller_info, recurse])
    info "#{__MODULE__} enqueued:#{jid}"
  end

  # Server (callbacks)

  def perform(resource, caller_info, recurse) do
    info "#{__MODULE__} perform:#{resource}"

    create_url(resource)
    |> recurse(caller_info, 1, recurse)
  end

  defp recurse(nil, _callername, _attempt), do: nil
  defp recurse(current_link, caller_info, attempt, recurse \\ true) do
    info "#{__MODULE__} recurse:#{current_link}, attempt:#{attempt}/#{@max_retries}"

    response = current_link |> http_get

    response
    |> process_response_body(current_link, caller_info, attempt)
    |> GitLab.ResponseDispatcher.send(caller_info)

    info "#{__MODULE__} recurse ending:#{current_link}"
    if recurse do
      response
      |> HTTP.Headers.get_next_link(current_link)
      |> recurse(caller_info, 1)
    end
  end

  defp create_url(resource), do: api_path() <> resource
  defp http_get(path), do: http_adaptor().get(path, headers())

  defp process_response_body({:ok, body}, _link, _caller_name, _attempt) do
    body.body
    |> Poison.decode!
    |> format
  end
  defp process_response_body({:error, _}, link, caller_info, attempt) when attempt < @max_retries do
    recurse(link, caller_info, attempt + 1)
  end
  defp process_response_body({:error, _}, link, _caller_name, _attempt) do
    info "#{__MODULE__} Gave up on:#{link}"
  end

  defp format(json) when is_list(json), do: json |> Enum.map(fn(a) -> format(a) end)
  defp format(json), do: json |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)

  defp headers(), do: ["PRIVATE-TOKEN": private_token()]
  defp api_path(), do: api_endpoint() <> @api_version
  defp api_endpoint(), do: config()[:api_endpoint]
  defp private_token(), do: config()[:private_token]
  defp http_adaptor(), do: config()[:http_adaptor]
end
