defmodule GitLab.Base do
  use Confex, otp_app: :lab_stat_ex

  @api_version "/api/v4"

  def get(project_id, path) do
    stringify(project_id)
    |> create_url(path)
    |> get
    |> process_response_body
  end

  defp stringify(int_or_string) when is_integer(int_or_string), do: Integer.to_string(int_or_string)
  defp stringify(int_or_string), do: int_or_string

  defp create_url(project_id, resource) do
    api_endpoint() <> @api_version <> "/projects/" <> project_id <> resource
  end

  defp get(path) do
    HTTPoison.get(path, headers())
  end

  defp process_response_body({:ok, body}) do
    body.body
    |> Poison.decode!
    |> Enum.map(fn(a) -> Enum.map(a, fn({k, v}) -> {String.to_atom(k), v} end) end)
  end

  defp headers(), do: ["PRIVATE-TOKEN": private_token()]
  defp api_endpoint(), do: config()[:api_endpoint]
  defp private_token(), do: config()[:private_token]
end
