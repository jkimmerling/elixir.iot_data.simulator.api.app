defmodule DataSimulatorApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @port_number String.to_integer(System.get_env("PORT_NUMBER", "8008"))

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: DataSimulatorApi.Router, options: [port: @port_number]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DataSimulatorApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
