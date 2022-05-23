defmodule Ghapi.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Ghapi.Repo,
      GhapiWeb.Telemetry,
      {Phoenix.PubSub, name: Ghapi.PubSub},
      GhapiWeb.Endpoint
      # {Ghapi.Worker, arg}
    ]

    opts = [strategy: :one_for_one, name: Ghapi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GhapiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
