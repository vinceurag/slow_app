# SlowApp

This app is very slow when not optimized.

Each request to the dummy Weather API takes about 3 seconds.
If we need to get the weather for 5 cities, it would roughly take 15 seconds.
Try to lower the request time for all the 5 cities to less than 5 seconds.
A test is included so you can just run `mix test` to verify your solution.

Only modify `lib/slow_app.ex`.
As a challenge, try not to use Tasks or GenServers.

