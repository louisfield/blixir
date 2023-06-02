defmodule Blixir.RiotApi.Account do
  alias Blixir.RiotApi.Fetch

  def account_by_puuid(puuid) do
    Fetch.fetch("/riot/account/v1/accounts/by-puuid/#{puuid}")
  end

  def account_by_riot_id(game_name, tag_line) do
    Fetch.fetch("/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line})")
  end

  def account_by_access_token(token) do
    Fetch.fetch("/riot/account/v1/accounts/me", authorization: token)
  end

  def get_active_shard(game, puuid) do
    Fetch.fetch("/riot/account/v1/active-shards/by-game/#{game}/by-puuid/#{puuid}")
  end
end
