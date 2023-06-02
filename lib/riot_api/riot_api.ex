defmodule Blixir.RiotApi do
  alias __MODULE__.{Account, ChampionMastery}

  defdelegate account_by_puuid(puuid), to: Account
  defdelegate account_by_riot_id(game_name, tag_line), to: Account
  defdelegate account_by_access_token(token), to: Account
  defdelegate get_active_shard(game, puuid), to: Account

  defdelegate all_summoner_masteries(encrypted_summoner_id), to: ChampionMastery

  defdelegate mastery_by_champ(encrypted_summoner_id, champ_id), to: ChampionMastery

  defdelegate top_mastery_by_count(encrypted_summoner_id, count \\ 5), to: ChampionMastery
  defdelegate total_mastery_score(encrypted_summoner_id), to: ChampionMastery
end
