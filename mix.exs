defmodule Spoticall.Mixfile do
  use Mix.Project

  def project do
    [app: :spoticall,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Spoticall, []},
     applications: [:phoenix, :cowboy, :logger, :gettext, :ex_twilio]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.1.4"},
     {:gettext, "~> 0.9"},
     {:cowboy, "~> 1.0"},
     {:ex_twilio, "~>0.1.8"}
    ]
  end
end
