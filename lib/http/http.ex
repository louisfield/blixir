defmodule Blixir.HTTP do
  @moduledoc """
  Module for calling HTTP requests through the request module
  Holds the behaviour for HTTP
  """

  @callback get(String.t(), list(), list()) ::
              {:ok, {tuple(), list(), String.t()}} | {:error, any()}

  @callback post(String.t(), list(), list()) ::
              {:ok, {tuple(), list(), String.t()}} | {:error, any()}
  def get(url, headers, options \\ []),
    do: __MODULE__.Request.get(url, headers, options)

  def post(url, headers, options \\ []),
    do: __MODULE__.Request.post(url, headers, options)
end
