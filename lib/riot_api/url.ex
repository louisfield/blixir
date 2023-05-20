defmodule Blixir.RiotApi.Url do
  @moduledoc """
  Module for generating url using region and the path
  """

  @doc """
    Generates url by appeding region and url path to a generic url.
    Injects the api_key are a query paramter

    ## Examples
        iex> Blixir.RiotApi.Url.generate_url("euw1", "/test/url")
        "euw1.api.riotgames.com/test/url?api_key=my_key"
  """
  def generate_url(region, end_url),
    do:
      region
      |> generate_base_url()
      |> concat_end_of_url(end_url)
      |> inject_api_key()

  defp generate_base_url(region),
    do: region <> ".api.riotgames.com"

  defp concat_end_of_url(base_url, end_url),
    do: base_url <> end_url

  defp inject_api_key(url),
    do: url <> "?api_key=" <> auth_token()

  defp auth_token(),
    do: Application.fetch_env!(__MODULE__, :api_key)
end
