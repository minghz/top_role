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
{:ok, items_base} = File.read(file)
items_base = Jason.decode!(items_base) |> Map.get("baseitem")

file2 = Application.app_dir(:top_role, "priv/data/items.json")
{:ok, items} = File.read(file2)
items = Jason.decode!(items) |> Map.get("item")

all_items = items ++ items_base

# NOTE: something wrong with this filtering
weapons = Enum.filter(all_items, fn item -> Enum.any?(item, fn({k, _v}) -> k == "weaponCategory" end) end)
# gets all the weapon properties
#Enum.map(weapons, fn weapon ->
#  weapon |> Map.keys
#end) |> List.flatten |> Enum.uniq

Enum.each(all_items, fn item ->
  schema = %TopRole.Resources.Item{
    name: item["name"],
    rarity: item["rarity"],
    source: item["source"],
    type: item["type"],
    weight: (if item["weight"], do: Float.to_string(item["weight"]/1), else: nil)
  }
  TopRole.Repo.insert!(schema)
end)

Enum.each(weapons, fn weapon ->
  schema = %TopRole.Resources.Weapon{
    ability: (if Map.has_key?(weapon, "ability"), do: weapon["ability"], else: nil),
    age: weapon["age"],
    #    attached_spells: weapon["attachedSpells"],
    axe: weapon["axe"],
    charges: weapon["charges"],
    curse: weapon["curse"],
    description: weapon["description"],
    dmg1: weapon["dmg1"],
    dmg2: weapon["dmg2"],
    dmg_type: weapon["dmgType"],
    firearm: weapon["firearm"],
    name: weapon["name"],
    page: weapon["page"],
    #    property: weapon["property"],
    range: weapon["range"],
    rarity: weapon["rarity"],
    reload: weapon["reload"],
    #req_attune: weapon["reqAttune"],
    sentient: weapon["sentient"],
    source: weapon["source"],
    staff: weapon["staff"],
    sword: weapon["sword"],
    tier: weapon["tier"],
    type: weapon["type"],
    value: weapon["value"],
    weight: (if weapon["weight"], do: Float.to_string(weapon["weight"]/1), else: nil),
    weapon_category: weapon["weaponCategory"],
    wondrous: weapon["wondrous"],
    name: weapon["name"],
    rarity: weapon["rarity"],
    source: weapon["source"],
    type: weapon["type"]
  }
  TopRole.Repo.insert!(schema)
end)
