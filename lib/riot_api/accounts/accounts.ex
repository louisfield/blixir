defmodule Blixir.RiotApi.Accounts do
  alias __MODULE__.Account

  def account_by_puuid(region, puuid) do
    fetch_account(region, "/riot/account/v1/accounts/by-puuid/#{puuid}")
  end

  def account_by_riot_id(region, game_name, tag_line) do
    fetch_account(region, "/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line})")
  end

  def account_by_access_token(region, token) do
    fetch_account(region, "/riot/account/v1/accounts/me", authorization: token)
  end

  # Returns active shard struct, will change when come to it.
  def get_active_shard(region, game, puuid) do
    fetch_account(region, "/riot/account/v1/active-shards/by-game/#{game}/by-puuid/#{puuid}")
  end

  defp fetch_account(region, url, headers \\ []),
    do:
      Blixir.RiotApi.fetch_and_parse(
        region,
        %Account{},
        url,
        headers
      )
end
