# Comtile38

Comtile38 is your comrade for Tile38 command generation in Elixir. Intended for use inside [Livebook](https://livebook.dev/). Livebook is a web application for writing interactive and collaborative code notebooks for Elixir. Comtile38 helps you generate correct commands with the right arity. You can then use your favorite Elixir RESP client to push them to the Tile38 geospatial database.

It parses the [Tile38 commands documentation](https://github.com/tidwall/tile38/blob/master/core/commands.json) and generates functions in compile-time. All functions are defined in the `Comtile38` module.

## Installation

Add the `:comtile38` dependency to your `mix.exs` file:

```elixir
defp dependencies do
  [{:comtile38, ">= 0.0.0"}]
end
```

Then run `$ mix deps.get` to install it.

You also get nice [documentation](https://hexdocs.pm/comtile38/0.0.1/Comtile38.html) for each command directly from the Tile38's documentation.
You can even check it out right off your IEx session.


![screenshot](https://media.giphy.com/media/uVwSwMROJsVKqKQjTh/giphy.gif)
![screenshot](https://media.giphy.com/media/kTWURvRof4g7EmVSti/giphy.gif)


