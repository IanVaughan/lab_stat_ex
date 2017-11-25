defmodule GitLab.Base do
  use Confex, otp_app: :lab_stat_ex

  @api_version "/api/v4"

  def get(resource) do
    create_url(resource)
    |> http_get
    |> process_response_body
  end

  defp create_url(resource), do: api_path() <> resource
  defp http_get(path), do: HTTPoison.get(path, headers())

  defp process_response_body({:ok, body}) do
    body.body
    |> Poison.decode!
    |> format
  end

  defp format(json) when is_list(json) do
    json
    |> Enum.map(fn(a) -> Enum.map(a, fn({k, v}) -> {String.to_atom(k), v} end) end)
  end

  defp format(json) do
    json
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  defp headers(), do: ["PRIVATE-TOKEN": private_token()]
  defp api_path(), do: api_endpoint() <> @api_version
  defp api_endpoint(), do: config()[:api_endpoint]
  defp private_token(), do: config()[:private_token]
end
