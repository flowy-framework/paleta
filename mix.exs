defmodule Paleta.MixProject do
  use Mix.Project

  @repo_url "https://github.com/flowy-framework/paleta"
  @name "Paleta"
  @version "0.1.1"

  def project do
    [
      app: :paleta,
      version: @version,
      elixir: "~> 1.14",
      description: "An Elixir UI components library to make engineers' life easier.",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      config_path: "./config/config.exs",
      test_coverage: [tool: ExCoveralls],
      package: package(),
      # Docs
      name: @name,
      source_url: @repo_url,
      homepage_url: "https://hex.pm/packages/paleta",
      docs: docs()
    ]
  end

  defp docs do
    [
      logo: "docs/images/logo.png",
      source_ref: "v#{@version}",
      source_url: @repo_url,
      main: @name,
      extras: []
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => @repo_url
      },
      files: ~w(priv mix.exs priv lib README.md)
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Phoenix
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.4", only: :dev},
      {:phoenix_live_view, "~> 0.20"},
      # {:phoenix_live_view,
      #  github: "phoenixframework/phoenix_live_view", branch: "main", override: true},
      {:jason, "~> 1.0"},
      {:timex, ">= 0.0.0"},
      {:excoveralls, "~> 0.15", only: :test},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.8", only: :dev},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:heroicons, "~> 0.5.0"},
      {:earmark, "~> 1.4"},
      {:makeup, "~> 1.1"},
      {:makeup_elixir, "~> 0.16"},

      # Assets bundling
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      {:esbuild, "~> 0.5", runtime: Mix.env() == :dev},
      {:inflex, "~> 2.1.0"}
    ]
  end

  defp aliases do
    [
      coverage: "coveralls.lcov",
      "assets.watch": [
        "tailwind default --watch",
        "esbuild default --watch",
        # This is needed to trigger the live reload and to reflect the changes made when you remove classes from the components
        "phx.digest"
      ],
      "assets.build": ["esbuild default", "tailwind default", "phx.digest", "phx.digest.clean"],
      "assets.build.no_diggest": ["esbuild default", "tailwind default"]
    ]
  end
end
