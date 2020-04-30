defmodule SlowAppTest do
  use ExUnit.Case

  # DO NOT MODIFY

  test "does not exceed 5 seconds" do
    cities = ~w(london manila hamburg tokyo seoul)

    {uSecs, results} = :timer.tc(fn -> SlowApp.get_weather_for_all_cities(cities) end)
    time_in_secs = uSecs / 1_000_000

    cities_from_results = Enum.map(results, & &1.city)

    assert Enum.all?(cities_from_results, &(&1 in cities))
    assert time_in_secs < 5
  end
end
