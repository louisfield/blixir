defmodule Blixir.RiotApi.Account do
  alias Blixir.HTTP
  alias Blixir.RiotApi.Url

  # Hardcode for now since have not decided how to handle region yet
  @region "euw1"

  def account_by_puuid(puuid) do
    @region
    |> Url.generate_url("/riot/account/v1/accounts/by-puuid/#{puuid}")
    |> HTTP.get([])
  end

  def account_by_riot_id(game_name, tag_line) do
    @region
    |> Url.generate_url("/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line})")
    |> HTTP.get([])
  end

  def account_by_access_token(token) do
    @region
    |> Url.generate_url("/riot/account/v1/accounts/me")
    |> HTTP.get(authorization: token)
  end

  def get_active_shard(game, puuid) do
    @region
    |> Url.generate_url("/riot/account/v1/active-shards/by-game/#{game}/by-puuid/#{puuid}")
    |> HTTP.get([])
  end
end
