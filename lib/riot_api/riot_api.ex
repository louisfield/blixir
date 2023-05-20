defmodule Blixir.RiotApi do
  alias __MODULE__.Account

  defdelegate account_by_puuid(puuid), to: Account
  defdelegate account_by_riot_id(game_name, tag_line), to: Account
  defdelegate account_by_access_token(token), to: Account
  defdelegate get_active_shard(game, puuid), to: Account
end
