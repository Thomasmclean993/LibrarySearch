defmodule LibrarySearch.Searchs do
  @moduledoc """
  The Searchs context.
  """

  import Ecto.Query, warn: false

  alias LibrarySearch.Searchs.Query

  def send_to_api(user_input) do
    converted_input = convert_query(user_input)

    case HTTPoison.get("http://openlibrary.org/search.json?q=#{converted_input}", [],
           ssl: [versions: [:"tlsv1.2"]]
         ) do
      {:ok, response} ->
        {:ok, response}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def convert_query(string) when string == " ", do: "Not an acceptable query, Please try again."

  def convert_query(string) do
    string
    |> String.downcase()
    |> String.replace(" ", "+")
  end

  def change_query(%Query{} = query, attrs \\ %{}) do
    Query.changeset(query, attrs)
  end
end
