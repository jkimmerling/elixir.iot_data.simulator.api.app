defmodule DataSimulatorApiTest do
  use ExUnit.Case
  doctest DataSimulatorApi

  test "greets the world" do
    assert DataSimulatorApi.hello() == :world
  end
end
