defmodule DataSimulatorApi.DataSimulator do
  require Jason

  def return_project_data(project) do
    {:ok, json_msg} = Jason.encode(%{"#{project}": simulate_project_data()})
    json_msg
  end

  def simulate_project_data() do
    number_of_points = String.to_integer(System.get_env("NUMBER_OF_POINTS"))

    Enum.map(1..number_of_points, fn point_number ->
      %{
        device: "#{System.get_env("POINT_PREFIX")}#{point_number}",
        reading: "#{:rand.uniform(100)}",
        time: "#{DateTime.to_string(DateTime.utc_now())}"
      }
    end)
  end
end
