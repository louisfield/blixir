defmodule Blixir.RiotApi.Summoners do
  import Blixir.HTTP, only: [prepare_and_get: 1]

  alias __MODULE__.Summoner

  @ok_resp {'HTTP/1.1', 200, 'OK'}

  @spec get_summoner_by_name(any) :: any
  def get_summoner_by_name(name) do
    with {:ok, {@ok_resp, [_ | _], body}} <-
           prepare_and_get("/lol/summoner/v4/summoners/by-name/#{name}"),
         {:ok, body} <- Jason.decode(body),
         %Summoner{} = body <- parse_body(body) do
      body
    else
      {:error, %Jason.DecodeError{}} ->
        {:error, :error_decoding_response}

      err ->
        err
    end
  end

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
