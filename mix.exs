defmodule QuenyaUtil.MixProject do
  use Mix.Project

  def project do
    [
      app: :quenya_util,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:yaml_elixir, "~> 2.5"},
      {:plug, "~>1.11"},
      {:jason, "~> 1.2"},
      {:uuid, "~> 1.0"},
      {:deep_merge, "~> 1.0"}
    ]
  end
end
