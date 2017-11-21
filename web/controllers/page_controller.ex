defmodule LabStatEx.PageController do
  use LabStatEx.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
