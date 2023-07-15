defmodule LibrarySearch.SearchsTest do
  use LibrarySearch.DataCase
  use ExUnit.Case, async: true
  use Mimic.DSL

  alias LibrarySearch.Searchs
  alias Support.Fixtures.FixtureHelper

  describe "convert_query/1" do
    test "Successfully convert a query to the correct format" do
      user_input = "the Lord of the Rings"
      assert Searchs.convert_query(user_input) == "the+lord+of+the+rings"
    end

    test "converts a single word response" do
      user_input = "Lord"

      assert Searchs.convert_query(user_input) == "lord"
    end

    test "converts a empty response without adding unnecessary +" do
      empty_input = " "

      assert Searchs.convert_query(empty_input) == "Not an acceptable query, Please try again."
    end
  end

  describe "Send_to_api/1" do
    test "Confirm a successful HTTPoison request is sent" do
      user_input = "the lord of the rings"
      response = FixtureHelper.retrieve_sample("lord_of_the_rings")

      expect(HTTPoison.get(_, _, _), do: {:ok, response})

      assert {:ok, response} == Searchs.send_to_api(user_input)
    end

    test "When query fails, returns a not found error" do
      user_input = "the lord of the rings"

      expect(HTTPoison.get(_, _, _), do: {:error, %HTTPoison.Error{}})

      assert {:error, %HTTPoison.Error{reason: nil, id: nil}} == Searchs.send_to_api(user_input)
    end
  end
end
