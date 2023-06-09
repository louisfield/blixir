defmodule Blixir.RiotApi.Accounts.Account do
  defstruct [
    :tag,
    :game_name,
    :puuid
  ]

  @type t :: %__MODULE__{
          game_name: String.t(),
          tag: String.t(),
          puuid: String.t()
        }
end
