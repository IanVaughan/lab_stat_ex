defmodule GitLab.Base do
  use Confex, otp_app: :lab_stat_ex
  # import Poison, only: [decode: 1]

  @api_version "/api/v4"

  def get(resource) do
    create_url(resource)
    |> recurse
  end

  defp recurse(link, response \\ []) do
    raw_response = link |> http_get

    next_link = raw_response |> HTTP.Headers.get_next_link

    res = process_response_body(raw_response)
    response = res ++ response

    if next_link do
      recurse(next_link, response)
    else
      response
    end
  end

  defp create_url(resource), do: api_path() <> resource
  defp http_get(path), do: http_adaptor().get(path, headers())

  defp process_response_body({:ok, body}) do
    body.body
    |> Poison.decode!
    |> format
  end

  defp format(json) when is_list(json), do: json |> Enum.map(fn(a) -> format(a) end)
  defp format(json), do: json |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)

  defp headers(), do: ["PRIVATE-TOKEN": private_token()]
  defp api_path(), do: api_endpoint() <> @api_version
  defp api_endpoint(), do: config()[:api_endpoint]
  defp private_token(), do: config()[:private_token]
  defp http_adaptor(), do: config()[:http_adaptor]
end
