defmodule Blixir.HTTP.Request do
  @moduledoc """
  Functionality for performing HTTP Requests
  """
  @behaviour Blixir.HTTP

  @content_type 'application/json'

  @callback get(String.t(), list(), list()) ::
              {:ok, {tuple(), list(), String.t()}} | {:error, any()}

  @callback post(String.t(), list(), list()) ::
              {:ok, {tuple(), list(), String.t()}} | {:error, any()}

  @doc """
    Sends a HTTP request with GET method, with parsed url, headers and opts

    ## Examples
        iex> Blixir.HTTP.Request.get("https://mywebsite.com", [], [])
        {:ok, [{'HTTP/1.1', 200, 'OK'}, [], 'mybody']}

  """
  def get(url, headers, options \\ []) do
    :get
    |> do_request({url, headers}, options)
  end

  @doc """
    Sends a HTTP request with POST method, with parsed url, body, headers and opts
  """
  def post(url, body, headers, options \\ []) do
    :post
    |> do_request({url, headers, @content_type, body}, options)
  end

  defp do_request(method, content, opts) do
    :httpc.request(method, content, http_request_opts(), opts)
  end

  defp http_request_opts(),
    do: [
      ssl: [
        verify: :verify_peer,
        cacerts: :public_key.cacerts_get(),
        customize_hostname_check: [
          match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
        ]
      ]
    ]
end
