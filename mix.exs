defmodule BotFramework.Mixfile do
  use Mix.Project

  def project do
    [app: :bot_framework,
     version: "0.2.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison],
     mod: {BotFramework, []}]
  end

  def description do
    "Microsoft Bot Framework Client in Elixir"
  end

  def package do
    [
      licenses: ["MIT License"],
      maintainers: ["Yuya Yabe"],
      links: %{
        "Github" => "https://github.com/yuyabee/bot_framework",
        "Docs" => "https://hexdocs.pm/bot_framework/"
      }
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:joken, "~> 1.2"},
      {:jose, "~> 1.7"},
      {:poison, "~> 2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
