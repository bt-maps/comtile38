defmodule Comtile38.Mixfile do
  use Mix.Project

  @description """
  comtile38 is your comrade for Tile38 command generation in Elixir.
  """

  def project do
    [app: :comtile38,
     version: "0.0.1",
     elixir: "~> 1.3",
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
      {:poison, "~> 5.0"},
      {:earmark, "~> 0.2.1", only: :dev},
      {:ex_doc, "~> 0.28.3", only: :dev},
      {:redix, "~> 1.1", only: :test},
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
