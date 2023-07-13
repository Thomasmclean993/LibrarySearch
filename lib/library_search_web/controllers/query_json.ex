defmodule LibrarySearchWeb.QueryJSON do
  alias LibrarySearch.Searchs.Query

  @doc """
  Renders a list of queries.
  """
  def index(%{queries: queries}) do
    %{data: for(query <- queries, do: data(query))}
  end

  @doc """
  Renders a single query.
  """
  def show(%{query: query}) do
    %{data: data(query)}
  end

  defp data(%Query{} = query) do
    %{
      id: query.id,
      query: query.query,
      query_with_add_ons: query.query_with_add_ons
    }
  end
end
