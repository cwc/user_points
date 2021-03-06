defmodule UserPoints.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      UserPoints.Repo,
      # Start the Telemetry supervisor
      UserPointsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: UserPoints.PubSub},
      # Start the Endpoint (http/https)
      UserPointsWeb.Endpoint,

      UserPoints.Engine
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UserPoints.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    UserPointsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
