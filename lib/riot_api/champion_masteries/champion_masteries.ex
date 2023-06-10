defmodule Blixir.RiotApi.ChampionMasteries do
  alias __MODULE__.ChampionMastery

  def all_summoner_masteries(region, encrypted_summoner_id) do
    fetch_account(
      region,
      "/lol/champion-mastery/v4/champion-masteries/by-summoner/#{encrypted_summoner_id}"
    )
  end

  def mastery_by_champ(region, encrypted_summoner_id, champ_id) do
    fetch_account(
      region,
      "/lol/champion-mastery/v4/champion-masteries/by-summoner/#{encrypted_summoner_id}/by-champion/#{champ_id}"
    )
  end

  def top_mastery_by_count(region, encrypted_summoner_id, count) do
    fetch_account(
      region,
      "/lol/champion-mastery/v4/champion-masteries/by-summoner/#{encrypted_summoner_id}/top?count=#{count}"
    )
  end

  def total_mastery_score(region, encrypted_summoner_id) do
    fetch_account(region, "/lol/champion-mastery/v4/scores/by-summoner/#{encrypted_summoner_id}")
  end

  defp fetch_account(region, url, headers \\ []),
    do:
      Blixir.RiotApi.fetch_and_parse(
        region,
        %ChampionMastery{},
        url,
        headers
      )
end
