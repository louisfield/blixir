defmodule Blixir.RiotApi do
  alias __MODULE__.{Accounts, Summoners, ChampionMasteries}

  import Blixir.HTTP, only: [prepare_and_get: 3]

  @ok_resp {'HTTP/1.1', 200, 'OK'}

  defdelegate account_by_puuid(region, puuid), to: Accounts
  defdelegate account_by_riot_id(region, game_name, tag_line), to: Accounts
  defdelegate account_by_access_token(region, token), to: Accounts
  defdelegate get_active_shard(region, game, puuid), to: Accounts

  defdelegate all_summoner_masteries(region, encrypted_summoner_id), to: ChampionMasteries

  defdelegate mastery_by_champ(region, encrypted_summoner_id, champ_id), to: ChampionMasteries

  defdelegate top_mastery_by_count(region, encrypted_summoner_id, count \\ 5),
    to: ChampionMasteries

  defdelegate total_mastery_score(region, encrypted_summoner_id), to: ChampionMasteries

  @spec get_summoner_by_name(String.t(), String.t()) ::
          {:ok, Summoners.Summoner.t()} | {:error, any()}
  defdelegate get_summoner_by_name(region, name), to: Summoners

  @spec fetch_and_parse(atom(), struct(), String.t(), fun(), list()) ::
          {:ok, struct()} | {:error, any()}
  @spec fetch_and_parse(atom(), struct(), String.t(), fun()) :: {:ok, struct()} | {:error, any()}
  @spec fetch_and_parse(atom(), struct(), String.t(), list()) :: {:ok, struct()} | {:error, any()}
  @spec fetch_and_parse(atom(), struct(), String.t()) :: {:ok, struct()} | {:error, any()}

  def fetch_and_parse(region, struct, url, headers) when is_list(headers) do
    fetch_and_parse(region, struct, url, &parse_body/2, headers)
  end

  def fetch_and_parse(region, struct, url, parse_body_callback \\ &parse_body/2, headers \\ []) do
    with {:ok, {@ok_resp, [_ | _], body}} <-
           prepare_and_get(region, url, headers),
         {:ok, body} <- Jason.decode(body),
         ^struct = body <- run_callback(parse_body_callback, struct, body) do
      {:ok, body}
    else
      {:error, %Jason.DecodeError{}} ->
        {:error, :error_decoding_response}

      err ->
        err
    end
  end

  defp run_callback(callback, struct, body) do
    if(callback == (&parse_body/2)) do
      parse_body(struct, body)
    else
      callback.(body)
    end
  end

  defp parse_body(struct, body) when is_list(body),
    do: Enum.map(body, &parse_body(struct, &1))

  defp parse_body(struct, body) do
    body
    |> Map.new(&convert_key_to_camel/1)
    |> maybe_into_struct(struct)
  end

  defp maybe_into_struct({:error, _} = e, _struct), do: e

  defp maybe_into_struct(val, struct),
    do: struct(struct, val)

  defp convert_key_to_camel(nil),
    do: nil

  defp convert_key_to_camel({k, v}),
    do:
      k
      |> Macro.underscore()
      |> String.to_atom()
      |> then(&{&1, v})
end
