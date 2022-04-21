defmodule Comtile38.Mixfile do
  use Mix.Project

  @description """
  comtile38 is your comrade for Tile38 command generation in Elixir (fork of comredis).
  """

  def project do
    [app: :comtile38,
     version: "1.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     name: "Comtile38",
     source_url: "https://github.com/bt-maps/comtile38",
     description: @description,
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:poison, ">= 1.0.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:redix, ">= 0.0.0", only: :test},
      {:excheck, "~> 0.3", only: :test},
      {:triq, github: "krestenkrab/triq", only: :test},
    ]
  end

  defp package do
    [ maintainers: ["Brent Tucker"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/bt-maps/comtile38"} ]
  end
end
