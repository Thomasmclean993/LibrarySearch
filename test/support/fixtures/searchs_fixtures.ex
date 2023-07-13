defmodule LibrarySearch.SearchsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LibrarySearch.Searchs` context.
  """

  @doc """
  Generate a query.
  """
  def query_fixture(attrs \\ %{}) do
    {:ok, query} =
      attrs
      |> Enum.into(%{
        query: "some query",
        query_with_add_ons: "some query_with_add_ons"
      })
      |> LibrarySearch.Searchs.create_query()

    query
  end
end
