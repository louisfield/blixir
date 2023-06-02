defmodule Blixir.RiotApi.Fetch do
  alias Blixir.HTTP
  alias Blixir.RiotApi.Url

  # Hardcode for now since have not decided how to handle region yet
  @region "euw1"

  def fetch(url, headers \\ []) do
    @region
    |> Url.generate_url(url)
    |> HTTP.get(headers)
  end
end
