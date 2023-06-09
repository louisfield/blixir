defmodule Blixir.RiotApi.SummonersTest do
  use ExUnit.Case

  import Mox

  alias Blixir.{HTTPMock, RiotApi.Summoners}
  alias Summoners.Summoner

  setup :verify_on_exit!

  @correct_http_resp {'HTTP/1.1', 200, 'OK'}
  @correct_http_body '{"id":"test_id","accountId":"test_account_id","puuid":"test_puuid","name":"test_name","profileIconId":4151,"revisionDate":1686081056000,"summonerLevel":424}'
  @incorrect_revision_date_body '{"id":"test_id","accountId":"test_account_id","puuid":"test_puuid","name":"test_name","profileIconId":4151,"summonerLevel":424}'

  @correct_overall_resp {:ok, {@correct_http_resp, [1, 2], @correct_http_body}}
  @invalid_revision_date {:ok, {@correct_http_resp, [1, 2], @incorrect_revision_date_body}}

  @correct_output_summoner %Summoner{
    account_id: "test_account_id",
    id: "test_id",
    name: "test_name",
    profile_icon_id: 4151,
    puuid: "test_puuid",
    revision_date: ~U[2023-06-06 19:50:56.000Z],
    summoner_level: 424
  }

  @region "euw1"

  describe "get_summoner_by_name/1" do
    test "Return summoner correctly when successful HTML request" do
      stub_with_response(@correct_overall_resp)

      assert @correct_output_summoner == Summoners.get_summoner_by_name(@region, "test")
    end

    test "Return revision date error when no revision date parsed" do
      stub_with_response(@invalid_revision_date)

      assert {:error, :could_not_convert_revision_date} ==
               Summoners.get_summoner_by_name(@region, "test")
    end
  end

  defp stub_with_response(resp),
    do:
      stub(HTTPMock, :get, fn _, _, _ ->
        resp
      end)
end
