defmodule Ledger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = [
      example: [
        strategy: Cluster.Strategy.Epmd,
        config: [hosts: [:"a@127.0.0.1", :"b@127.0.0.1"]]
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: Ledger.ClusterSupervisor]]},
      # Start the Ecto repository
      Ledger.Repo,
      # Start the Telemetry supervisor
      LedgerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ledger.PubSub},
      # Start the Endpoint (http/https)
      LedgerWeb.Endpoint
      # Start a worker by calling: Ledger.Worker.start_link(arg)
      # {Ledger.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ledger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LedgerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
