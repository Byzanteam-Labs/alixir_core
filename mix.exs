defmodule AlixirCore.MixProject do
  use Mix.Project

  @project_host "https://github.com/GreenNerd-Labs/alixir_core"
  @version "0.1.3"

  def project do
    [
      app: :alixir_core,
      version: @version,
      source_url: @project_host,
      homepage_url: @project_host,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:timex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.2.0"},
      {:timex, "~> 3.3"},
      {:elixir_uuid, "~> 1.2"},
      {:ex_doc, "~> 0.18.0", only: :dev}
    ]
  end

  defp description do
    "Aliyun Core modules."
  end

  defp package do
    [
      name: :alixir_core,
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["fahchen"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_host}
    ]
  end
end
