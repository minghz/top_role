defmodule TopRole.ResourcesTest do
  use TopRole.DataCase

  alias TopRole.Resources

  describe "weapons" do
    alias TopRole.Resources.Weapon

    @valid_attrs %{ability: %{}, age: "some age", attached_spells: "some attached_spells", axe: true, charges: 42, curse: true, description: "some description", dmg1: "some dmg1", dmg2: "some dmg2", dmg_type: "some dmg_type", firearm: true, name: "some name", page: "some page", property: "some property", range: "some range", rarity: "some rarity", reload: 42, req_attune: "some req_attune", sentient: true, source: "some source", staff: true, sword: true, tier: "some tier", type: "some type", value: "some value", weapon_category: "some weapon_category", weight: "some weight", wondrous: true}
    @update_attrs %{ability: %{}, age: "some updated age", attached_spells: "some updated attached_spells", axe: false, charges: 43, curse: false, description: "some updated description", dmg1: "some updated dmg1", dmg2: "some updated dmg2", dmg_type: "some updated dmg_type", firearm: false, name: "some updated name", page: "some updated page", property: "some updated property", range: "some updated range", rarity: "some updated rarity", reload: 43, req_attune: "some updated req_attune", sentient: false, source: "some updated source", staff: false, sword: false, tier: "some updated tier", type: "some updated type", value: "some updated value", weapon_category: "some updated weapon_category", weight: "some updated weight", wondrous: false}
    @invalid_attrs %{ability: nil, age: nil, attached_spells: nil, axe: nil, charges: nil, curse: nil, description: nil, dmg1: nil, dmg2: nil, dmg_type: nil, firearm: nil, name: nil, page: nil, property: nil, range: nil, rarity: nil, reload: nil, req_attune: nil, sentient: nil, source: nil, staff: nil, sword: nil, tier: nil, type: nil, value: nil, weapon_category: nil, weight: nil, wondrous: nil}

    def weapon_fixture(attrs \\ %{}) do
      {:ok, weapon} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_weapon()

      weapon
    end

    test "list_weapons/0 returns all weapons" do
      weapon = weapon_fixture()
      assert Resources.list_weapons() == [weapon]
    end

    test "get_weapon!/1 returns the weapon with given id" do
      weapon = weapon_fixture()
      assert Resources.get_weapon!(weapon.id) == weapon
    end

    test "create_weapon/1 with valid data creates a weapon" do
      assert {:ok, %Weapon{} = weapon} = Resources.create_weapon(@valid_attrs)
      assert weapon.ability == %{}
      assert weapon.age == "some age"
      assert weapon.attached_spells == "some attached_spells"
      assert weapon.axe == true
      assert weapon.charges == 42
      assert weapon.curse == true
      assert weapon.description == "some description"
      assert weapon.dmg1 == "some dmg1"
      assert weapon.dmg2 == "some dmg2"
      assert weapon.dmg_type == "some dmg_type"
      assert weapon.firearm == true
      assert weapon.name == "some name"
      assert weapon.page == "some page"
      assert weapon.property == "some property"
      assert weapon.range == "some range"
      assert weapon.rarity == "some rarity"
      assert weapon.reload == 42
      assert weapon.req_attune == "some req_attune"
      assert weapon.sentient == true
      assert weapon.source == "some source"
      assert weapon.staff == true
      assert weapon.sword == true
      assert weapon.tier == "some tier"
      assert weapon.type == "some type"
      assert weapon.value == "some value"
      assert weapon.weapon_category == "some weapon_category"
      assert weapon.weight == "some weight"
      assert weapon.wondrous == true
    end

    test "create_weapon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_weapon(@invalid_attrs)
    end

    test "update_weapon/2 with valid data updates the weapon" do
      weapon = weapon_fixture()
      assert {:ok, %Weapon{} = weapon} = Resources.update_weapon(weapon, @update_attrs)
      assert weapon.ability == %{}
      assert weapon.age == "some updated age"
      assert weapon.attached_spells == "some updated attached_spells"
      assert weapon.axe == false
      assert weapon.charges == 43
      assert weapon.curse == false
      assert weapon.description == "some updated description"
      assert weapon.dmg1 == "some updated dmg1"
      assert weapon.dmg2 == "some updated dmg2"
      assert weapon.dmg_type == "some updated dmg_type"
      assert weapon.firearm == false
      assert weapon.name == "some updated name"
      assert weapon.page == "some updated page"
      assert weapon.property == "some updated property"
      assert weapon.range == "some updated range"
      assert weapon.rarity == "some updated rarity"
      assert weapon.reload == 43
      assert weapon.req_attune == "some updated req_attune"
      assert weapon.sentient == false
      assert weapon.source == "some updated source"
      assert weapon.staff == false
      assert weapon.sword == false
      assert weapon.tier == "some updated tier"
      assert weapon.type == "some updated type"
      assert weapon.value == "some updated value"
      assert weapon.weapon_category == "some updated weapon_category"
      assert weapon.weight == "some updated weight"
      assert weapon.wondrous == false
    end

    test "update_weapon/2 with invalid data returns error changeset" do
      weapon = weapon_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_weapon(weapon, @invalid_attrs)
      assert weapon == Resources.get_weapon!(weapon.id)
    end

    test "delete_weapon/1 deletes the weapon" do
      weapon = weapon_fixture()
      assert {:ok, %Weapon{}} = Resources.delete_weapon(weapon)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_weapon!(weapon.id) end
    end

    test "change_weapon/1 returns a weapon changeset" do
      weapon = weapon_fixture()
      assert %Ecto.Changeset{} = Resources.change_weapon(weapon)
    end
  end
end
