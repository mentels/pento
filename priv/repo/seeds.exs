# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pento.Catalog

products = [
  %{
    name: "Chess",
    description:
      "A two-player strategy board game played on a checkered board with 64 squares arranged in an 8×8 grid.",
    sku: 5_678_910,
    unit_price: 10.00
  },
  %{
    name: "Monopoly",
    description:
      "A board game that is played by two to eight players. It is a game of luck, strategy, and critical thinking.",
    sku: 1_234_567,
    unit_price: 20.00
  },
  %{
    name: "Risk",
    description:
      "A strategy board game of diplomacy, conflict and conquest for two to six players.",
    sku: 9_876_543,
    unit_price: 15.00
  }
]

Enum.each(products, fn product ->
  Catalog.create_product(product)
end)
