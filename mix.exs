defmodule ElixirIssues.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_issues,
      escript: escript_config(),
      version: "0.1.0",
      name: "Issues table",
      source_url: "https://github.com/biofilos/elixir_issues",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:httpoison, "~> 2.2.1"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:earmark, "~> 1.4"},
      {:poison, "~> 6.0"}
    ]
  end

  defp escript_config do
    [
      main_module: ElixirIssues.CLI
    ]
  end
end
