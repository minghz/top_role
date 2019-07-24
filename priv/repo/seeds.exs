# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TopRole.Repo.insert!(%TopRole.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

file = Application.app_dir(:top_role, "priv/data/items-base.json")

{:ok, data} = File.read(file)

items = Jason.decode!(data) |> Map.get("baseitem")

weapons = Enum.filter(items, fn item -> Enum.any?(item, fn({k, _v}) -> k == "weaponCategory" end) end)

Enum.each(weapons, fn weapon ->
	schema = %TopRole.Resources.Item{
		name: weapon["name"],
		rarity: weapon["rarity"],
		source: weapon["source"],
		type: weapon["type"],
		weight: (if weapon["weight"], do: Float.to_string(weapon["weight"]/1), else: 0)
  }
	TopRole.Repo.insert!(schema)
end)
