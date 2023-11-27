defmodule DataSimulatorApi.Router do
  use Plug.Router

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/:project" do
    send_resp(conn, 200, DataSimulatorApi.DataSimulator.return_project_data(project))
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
