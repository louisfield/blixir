defmodule Blixir.HTTP do
  @moduledoc """
  Module for calling HTTP requests through the request module
  Holds the behaviour for HTTP
  """

  alias Blixir.RiotApi.Url

  @callback get(String.t(), list(), list()) ::
              {:ok, {tuple(), list(), String.t()}} | {:error, any()}

  @callback post(String.t(), list(), list()) ::
              {:ok, {tuple(), list(), String.t()}} | {:error, any()}
  def get(url, headers, options \\ []),
    do: request().get(url, headers, options)

  def post(url, headers, options \\ []),
    do: request().post(url, headers, options)

  def prepare_and_get(region, url, headers \\ []),
    do:
      region
      |> Url.generate_url(url)
      |> IO.inspect()
      |> get(headers)

  defp request(), do: Application.fetch_env!(:blixir, __MODULE__)
end
