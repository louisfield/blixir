defmodule Blixir.RiotApi.ChampionMasteries.ChampionMastery do
  defstruct [
    :champion_id,
    :champion_level,
    :champion_points,
    :champion_points_since_last_level,
    :champion_points_until_next_level,
    :chest_granted,
    :last_play_time,
    :puuid,
    :summoner_id,
    :tokens_earned
  ]

  @type t :: %__MODULE__{
          champion_id: pos_integer(),
          champion_level: pos_integer(),
          champion_points: pos_integer(),
          champion_points_since_last_level: integer(),
          champion_points_until_next_level: integer(),
          chest_granted: boolean(),
          last_play_time: DateTime.t(),
          puuid: String.t(),
          summoner_id: String.t(),
          tokens_earned: integer()
        }
end
