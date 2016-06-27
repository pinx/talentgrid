defmodule Talentgrid.Mixfile do
  use Mix.Project

  def project do
    [app: :talentgrid,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Talentgrid, []},
     applications: [
      :phoenix,
      :postgrex,
      :phoenix_ecto,
      :phoenix_html,
      :ueberauth,
      :ueberauth_facebook,
      :facebook,
      :csv,
      :porcelain,
      :cowboy,
      :logger,
      :gettext]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_ecto, "~> 3.0-rc"},
     {:phoenix_html, "~> 2.5"},
     {:phoenix_haml, github: "pinx/phoenix_haml"},
     {:ueberauth, "~> 0.2"},
     {:ueberauth_facebook, "~> 0.3"},
     {:facebook, "~> 0.8.0"},
     {:csv, "~> 1.4.0"},
     {:porcelain, "~> 2.0"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:mix_test_watch, "~> 0.2", only: :dev},
     {:faker, "~> 0.5", only: [:prod, :dev, :test]},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"}]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
