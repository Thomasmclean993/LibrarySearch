defmodule LibrarySearchWeb.QueryControllerTest do
  use LibrarySearchWeb.ConnCase

  import LibrarySearch.SearchsFixtures

  alias LibrarySearch.Searchs.Query

  @create_attrs %{
    query: "some query",
    query_with_add_ons: "some query_with_add_ons"
  }
  @update_attrs %{
    query: "some updated query",
    query_with_add_ons: "some updated query_with_add_ons"
  }
  @invalid_attrs %{query: nil, query_with_add_ons: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all queries", %{conn: conn} do
      conn = get(conn, ~p"/api/queries")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create query" do
    test "renders query when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/queries", query: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/queries/#{id}")

      assert %{
               "id" => ^id,
               "query" => "some query",
               "query_with_add_ons" => "some query_with_add_ons"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/queries", query: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update query" do
    setup [:create_query]

    test "renders query when data is valid", %{conn: conn, query: %Query{id: id} = query} do
      conn = put(conn, ~p"/api/queries/#{query}", query: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/queries/#{id}")

      assert %{
               "id" => ^id,
               "query" => "some updated query",
               "query_with_add_ons" => "some updated query_with_add_ons"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, query: query} do
      conn = put(conn, ~p"/api/queries/#{query}", query: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete query" do
    setup [:create_query]

    test "deletes chosen query", %{conn: conn, query: query} do
      conn = delete(conn, ~p"/api/queries/#{query}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/queries/#{query}")
      end
    end
  end

  defp create_query(_) do
    query = query_fixture()
    %{query: query}
  end
end
