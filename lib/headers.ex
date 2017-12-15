defmodule HTTP.Headers do
  @moduledoc """
  Takes a HTTP Response and extracts the next link from the headers
  based on the standard "Link" key & "rel" schema
  """

  def get_next_link({:ok, response}, _current_link) do
    extract_links({:ok, response}, "next")
  end
  def get_next_link({:error, _}, current_link), do: current_link

  defp extract_links({:ok, response}, type) do
    response.headers
    |> Enum.find(fn({key, _b}) -> key == "Link" end)
    |> find_group_type(type)
    |> extract_group
  end

  defp find_group_type(nil, _), do: nil
  defp find_group_type({"Link", links}, type) do
    links
    |> String.split(",")
    |> Enum.find(fn(a) -> a |> String.contains?("rel=\"#{type}\"") end)
  end

  defp extract_group(nil), do: nil
  defp extract_group(group_of_type) do
    group_of_type
    |> String.split(";")
    |> List.first
    |> String.trim
    |> String.trim_leading("<")
    |> String.trim_trailing(">")
  end
end
