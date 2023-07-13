defmodule LibrarySearch.SearchsTest do
  use LibrarySearch.DataCase

  alias LibrarySearch.Searchs

  describe "queries" do
    alias LibrarySearch.Searchs.Query

    import LibrarySearch.SearchsFixtures

    @invalid_attrs %{query: nil, query_with_add_ons: nil}

    test "list_queries/0 returns all queries" do
      query = query_fixture()
      assert Searchs.list_queries() == [query]
    end

    test "get_query!/1 returns the query with given id" do
      query = query_fixture()
      assert Searchs.get_query!(query.id) == query
    end

    test "create_query/1 with valid data creates a query" do
      valid_attrs = %{query: "some query", query_with_add_ons: "some query_with_add_ons"}

      assert {:ok, %Query{} = query} = Searchs.create_query(valid_attrs)
      assert query.query == "some query"
      assert query.query_with_add_ons == "some query_with_add_ons"
    end

    test "create_query/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Searchs.create_query(@invalid_attrs)
    end

    test "update_query/2 with valid data updates the query" do
      query = query_fixture()
      update_attrs = %{query: "some updated query", query_with_add_ons: "some updated query_with_add_ons"}

      assert {:ok, %Query{} = query} = Searchs.update_query(query, update_attrs)
      assert query.query == "some updated query"
      assert query.query_with_add_ons == "some updated query_with_add_ons"
    end

    test "update_query/2 with invalid data returns error changeset" do
      query = query_fixture()
      assert {:error, %Ecto.Changeset{}} = Searchs.update_query(query, @invalid_attrs)
      assert query == Searchs.get_query!(query.id)
    end

    test "delete_query/1 deletes the query" do
      query = query_fixture()
      assert {:ok, %Query{}} = Searchs.delete_query(query)
      assert_raise Ecto.NoResultsError, fn -> Searchs.get_query!(query.id) end
    end

    test "change_query/1 returns a query changeset" do
      query = query_fixture()
      assert %Ecto.Changeset{} = Searchs.change_query(query)
    end
  end
end
