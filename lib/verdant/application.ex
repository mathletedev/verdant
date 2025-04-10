defmodule Verdant.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VerdantWeb.Telemetry,
      Verdant.Repo,
      {DNSCluster, query: Application.get_env(:verdant, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Verdant.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Verdant.Finch},
      # Start a worker by calling: Verdant.Worker.start_link(arg)
      # {Verdant.Worker, arg},
      # Start to serve requests, typically the last entry
      VerdantWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Verdant.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VerdantWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
