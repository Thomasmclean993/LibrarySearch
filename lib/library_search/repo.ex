defmodule LibrarySearch.Repo do
  use Ecto.Repo,
    otp_app: :library_search,
    adapter: Ecto.Adapters.Postgres
end
