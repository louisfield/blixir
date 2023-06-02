defmodule Blixir.RiotApi.Account do
  import Blixir.HTTP, only: [prepare_and_get: 1, prepare_and_get: 2]

  def account_by_puuid(puuid) do
    prepare_and_get("/riot/account/v1/accounts/by-puuid/#{puuid}")
  end

  def account_by_riot_id(game_name, tag_line) do
    prepare_and_get("/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line})")
  end

  def account_by_access_token(token) do
    prepare_and_get("/riot/account/v1/accounts/me", authorization: token)
  end

  def get_active_shard(game, puuid) do
    prepare_and_get("/riot/account/v1/active-shards/by-game/#{game}/by-puuid/#{puuid}")
  end
end
