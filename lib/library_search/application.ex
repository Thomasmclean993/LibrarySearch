defmodule LibrarySearch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LibrarySearchWeb.Telemetry,
      # Start the Ecto repository
      LibrarySearch.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LibrarySearch.PubSub},
      # Start Finch
      {Finch, name: LibrarySearch.Finch},
      # Start the Endpoint (http/https)
      LibrarySearchWeb.Endpoint
      # Start a worker by calling: LibrarySearch.Worker.start_link(arg)
      # {LibrarySearch.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LibrarySearch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LibrarySearchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
