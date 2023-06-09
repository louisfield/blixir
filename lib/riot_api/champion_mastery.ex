defmodule Blixir.RiotApi.ChampionMastery do
  # import Blixir.HTTP, only: [prepare_and_get: 2]

  # Commented out for further re-work
  # def all_summoner_masteries(encrypted_summoner_id) do
  #   prepare_and_get(
  #     "/lol/champion-mastery/v4/champion-masteries/by-summoner/#{encrypted_summoner_id}"
  #   )
  # end

  # def mastery_by_champ(encrypted_summoner_id, champ_id) do
  #   prepare_and_get(
  #     "/lol/champion-mastery/v4/champion-masteries/by-summoner/#{encrypted_summoner_id}/by-champion/#{champ_id}"
  #   )
  # end

  # def top_mastery_by_count(encrypted_summoner_id, count) do
  #   prepare_and_get(
  #     "/lol/champion-mastery/v4/champion-masteries/by-summoner/#{encrypted_summoner_id}/top?count=#{count}"
  #   )
  # end

  # def total_mastery_score(encrypted_summoner_id) do
  #   prepare_and_get("/lol/champion-mastery/v4/scores/by-summoner/#{encrypted_summoner_id}")
  # end
end
