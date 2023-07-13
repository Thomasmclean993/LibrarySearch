defmodule LibrarySearch.Repo.Migrations.CreateQueries do
  use Ecto.Migration

  def change do
    create table(:queries) do
      add :query, :string
      add :query_with_add_ons, :string

      timestamps()
    end
  end
end
