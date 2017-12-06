defmodule HTTP.HeadersTest do
  use ExUnit.Case, async: false
  alias HTTP.Headers, as: Subject

  test "when no Link key" do
    headers = [ {"Foo", "Bar"} ]
    response = %HTTPoison.Response{headers: headers}
    next_link = Subject.get_next_link({:ok, response})
    assert next_link == nil
  end

  describe "when Link key present" do
    test "when next rel present it returns that link" do
      headers = [
        {"Link", "<https://page2>; rel=\"next\", <https://page1>; rel=\"first\", <https://page3>; rel=\"last\""}
      ]
      response = %HTTPoison.Response{headers: headers}
      next_link = Subject.get_next_link({:ok, response})
      assert next_link == "https://page2"
    end

    test "when next rel missing it returns nil" do
      headers = [
        {"Link", "<https://page1>; rel=\"first\", <https://page3>; rel=\"last\""}
      ]
      response = %HTTPoison.Response{body: "", headers: headers, status_code: 200}
      next_link = Subject.get_next_link({:ok, response})
      assert next_link == nil
    end
  end
end
