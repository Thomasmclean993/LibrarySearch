defmodule LibrarySearch.Searchs.Query do
  use Ecto.Schema
  import Ecto.Changeset

  schema "queries" do
    field :query, :string
    field :query_with_add_ons, :string

    timestamps()
  end

  @doc false
  def changeset(query, attrs) do
    query
    |> cast(attrs, [:query, :query_with_add_ons])
    |> validate_required([:query, :query_with_add_ons])
  end
end
