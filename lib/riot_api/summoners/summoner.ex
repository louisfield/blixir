defmodule Blixir.RiotApi.Summoners.Summoner do
  defstruct [
    :account_id,
    :id,
    :name,
    :profile_icon_id,
    :puuid,
    :revision_date,
    :summoner_level
  ]

  @type t :: %__MODULE__{
          account_id: String.t(),
          id: String.t(),
          name: String.t(),
          profile_icon_id: integer(),
          puuid: String.t(),
          revision_date: DateTime.t(),
          summoner_level: integer()
        }
end
