defmodule Support.Fixtures.FixtureHelper do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LibrarySearch.Searchs` context.
  """

  @doc """
  Generate a query.
  """

  def retrieve_fixture("the lord of the rings") do
    File.read("test/support/fixtures/lord_of_the_rings.json")
  end

  def retrieve_sample(file) do
    file = "test/support/fixtures/#{file}.json"

    case File.read(file) do
      {:ok, file} -> file
      {:error, _} -> raise "Could not load fixture -> #{file}.json"
    end
  end
end
