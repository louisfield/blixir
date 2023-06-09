defmodule Blixir.RiotApi.Summoners do
  alias __MODULE__.Summoner

  @spec get_summoner_by_name(String.t(), String.t()) :: {:ok, Summoner.t()} | {:error, any()}
  def get_summoner_by_name(region, name),
    do: fetch_summoner(region, "/lol/summoner/v4/summoners/by-name/#{name}")

  defp fetch_summoner(region, url),
    do:
      Blixir.RiotApi.fetch_and_parse(
        region,
        %Summoner{},
        url,
        &parse_body/1
      )

  defp parse_body(body) do
    body
    |> Enum.map(&convert_key_to_camel/1)
    |> Enum.into(%{})
    |> maybe_convert_revision_date()
    |> maybe_into_struct()
  end

  defp maybe_into_struct({:error, _} = e), do: e

  defp maybe_into_struct(val),
    do: struct(Summoner, val)

  defp maybe_convert_revision_date(%{revision_date: revision_date} = summoner)
       when not is_nil(revision_date) do
    {:ok, datetime} = DateTime.from_unix(revision_date, :millisecond)

    %{summoner | revision_date: datetime}
  end

  defp maybe_convert_revision_date(_summoner),
    do: {:error, :could_not_convert_revision_date}

  defp convert_key_to_camel(nil),
    do: nil

  defp convert_key_to_camel({k, v}),
    do:
      k
      |> Macro.underscore()
      |> String.to_atom()
      |> then(&{&1, v})
end
