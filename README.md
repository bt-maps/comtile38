# Comtile38

Comtile38 is your comrade for Tile38 command generation in Elixir. It helps you generate correct commands with the right arity. You can then use your favorite Elixir client to push them to the Tile38 geospatial database.

It parses the [Tile38 commands documentation](https://github.com/tidwall/tile38/blob/master/core/commands.json) and generates functions in compile-time. All functions are defined in the `Comtile38` module.

## Installation

Add the `:comtile38` dependency to your `mix.exs` file:

```elixir
defp dependencies do
  [{:comtile38, ">= 0.0.0"}]
end
```

Then run `$ mix deps.get` to install it.

## Examples (TO DO)



You also get nice [documentation](https://hexdocs.pm/comtile38/Comtile38.html) for each command directly from the Tile38's documentation.
You can even check it out right off your IEx session.

```
 h Comtile38.sethook  
```
 def sethook(name, endpoint, nil, key, param, opts \\ [])            

Creates a webhook which points to geofenced search

Group: webhook

Arguments:

  • name string

  • endpoint string

  • meta optional, multiple, [string, string]

  • ex optional, [double]

  •  ["NEARBY", "WITHIN", "INTERSECTS"]

  • key string

  • fence

  • detect optional, [string]

  • commands optional, [string]

  • param string



