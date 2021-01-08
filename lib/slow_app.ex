defmodule SlowApp do
  @moduledoc """
  This app is very slow when not optimized.

  Each request to the dummy Weather API takes about 3 seconds.
  If we need to get the weather for the 5 cities, it would roughly take 15 seconds.
  Try to lower the request time for all the 5 cities to less than 5 seconds.

  Only modify this file.
  As a challenge, try not to use Tasks.

  Use `mix test` to verify your solution.
  """

  @type result :: %{
          city: String.t(),
          weather: String.t()
        }

  @doc """
  Returns the weather for all the cities.

  ## Examples

      iex> SlowApp.get_weather_for_all_cities(["london", "manila", "hamburg", "tokyo", "seoul"])
      [
        %{city: "seoul", weather: "windy"},
        %{city: "tokyo", weather: "windy"},
        %{city: "hamburg", weather: "sunny"},
        %{city: "manila", weather: "snowy"},
        %{city: "london", weather: "snowy"}
      ]

  """
  @spec get_weather_for_all_cities(cities :: [String.t()]) :: [result()]
  def get_weather_for_all_cities(cities) do
    caller_pid = self()

    cities
    |> Enum.map(fn city ->
      spawn(fn ->
        send(caller_pid, Weather.get_weather(city))
      end)
    end)

    result_collector([], Enum.count(cities))
  end

  defp result_collector(results, expected_results_count) do
    receive do
      :stop ->
        results

      result ->
        results = [result | results]

        if Enum.count(results) == expected_results_count, do: send(self(), :stop)
        result_collector(results, expected_results_count)
    end
  end
end
