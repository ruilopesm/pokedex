defmodule Pokedex.MixProject do
  use Mix.Project

  @app :pokedex
  @version "0.1.0"

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Pokedex.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # core
      {:phoenix, "~> 1.7.11"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.20.2"},
      {:bandit, "~> 1.2"},

      # frontend
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.1",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},

      # utilities
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:req, "~> 0.4.0"},
      {:timex, "~> 3.0"},

      # cache system
      {:nebulex, "~> 2.6"},
      {:decorator, "~> 1.4"},
      {:telemetry, "~> 1.0"},

      # development
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},

      # tools
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},

      # testing
      {:floki, ">= 0.30.0", only: :test},

      # monitoring
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind pokedex", "esbuild pokedex"],
      "assets.deploy": [
        "tailwind pokedex --minify",
        "esbuild pokedex --minify",
        "phx.digest"
      ],
      lint: ["credo --strict --all"]
    ]
  end
end
