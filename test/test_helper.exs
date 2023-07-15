[LibrarySearch.Searchs, HTTPoison]
|> Enum.each(&Mimic.copy/1)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(LibrarySearch.Repo, :manual)
