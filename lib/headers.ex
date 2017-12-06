# Takes a HTTP Response and extracts the next link from the headers
# based on the standard "Link" key & "rel" schema
defmodule HTTP.Headers do
  def get_next_link({:ok, response}) do
    response.headers
    |> Enum.find(fn({key, _b}) -> key == "Link" end)
    |> extract_links
  end

  defp extract_links(nil), do: nil
  defp extract_links({"Link", links}) do
    next_links = links
    |> String.split(",")
    |> Enum.find(fn(a) -> a |> String.contains?("rel=\"next\"") end)

    split = case next_links do
      nil -> nil
      _ -> next_links |> String.split(";")
    end

    if split do
      [link, _] = split
      link = link |> String.trim |> String.trim_leading("<") |> String.trim_trailing(">")

      link
    end
  end
end
