defmodule LibrarySearchWeb.QueryController do
  use LibrarySearchWeb, :controller

  alias LibrarySearch.Searchs
  alias LibrarySearch.Searchs.Query

  action_fallback LibrarySearchWeb.FallbackController

  def index(conn, _params) do
    queries = Searchs.list_queries()
    render(conn, :index, queries: queries)
  end

  def create(conn, %{"query" => query_params}) do
    with {:ok, %Query{} = query} <- Searchs.create_query(query_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/queries/#{query}")
      |> render(:show, query: query)
    end
  end

  def show(conn, %{"id" => id}) do
    query = Searchs.get_query!(id)
    render(conn, :show, query: query)
  end

  def update(conn, %{"id" => id, "query" => query_params}) do
    query = Searchs.get_query!(id)

    with {:ok, %Query{} = query} <- Searchs.update_query(query, query_params) do
      render(conn, :show, query: query)
    end
  end

  def delete(conn, %{"id" => id}) do
    query = Searchs.get_query!(id)

    with {:ok, %Query{}} <- Searchs.delete_query(query) do
      send_resp(conn, :no_content, "")
    end
  end
end
