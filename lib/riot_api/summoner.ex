defmodule Blixir.RiotApi.Summoner do
  import Blixir.HTTP, only: [prepare_and_get: 1]

  def get_summoner_by_name(name) do
    prepare_and_get("/lol/summoner/v4/summoners/by-name/#{name}")
  end
end
