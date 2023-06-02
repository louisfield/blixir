defmodule Blixir.HTTP.RequestTest do
  use ExUnit.Case, async: true

  alias Blixir.HTTP.Request

  @test_url "https://google.com"
  @bad_url "mybadurl://google.bad"
  @http_11 'HTTP/1.1'
  @status_ok 200
  @ok 'OK'

  describe "get/3" do
    test "successful GET request" do
      assert {:ok, {{@http_11, @status_ok, @ok}, [_ | _], html}} = Request.get(@test_url, [])

      assert {:ok, _html} = Floki.parse_document(html)
    end

    test "invalid GET request" do
      assert {:error, {:bad_scheme, [_ | _]}} = Request.get(@bad_url, [])
    end
  end
end
