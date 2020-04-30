defmodule Weather do
  @doc """
  Fake Weather API.

  DO NOT MODIFY THIS FILE
  """

  @valid_weather_list ~w(snowy windy rainy sunny)

  def get_weather(city) do
    Process.sleep(3000)

    %{city: city, weather: Enum.random(@valid_weather_list)}
  end
end
