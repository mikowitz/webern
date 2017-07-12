defmodule Webern.Mixfile do
  use Mix.Project

  @github_url "https://github.com/mikowitz/webern"

  def project do
    [app: :webern,
     name: "Webern",
     description: "Twelve-tone rows in Elixir",
     version: "0.1.0",
     elixir: "~> 1.4",
     package: [
       maintainers: ["Michael Berkowitz"],
       licenses: ["MIT"],
       links: %{"GitHub" => @github_url}
     ],
     source_url: @github_url,
     homepage_url: @github_url,

     docs: [
       extras: ["README.md"],
       main: "readme"
     ],

     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,

     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:credo, "~> 0.8.2"},
      {:dogma, "~> 0.1"},
      {:ex_doc, "~> 0.16.2"},
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false}
    ]
  end
end
