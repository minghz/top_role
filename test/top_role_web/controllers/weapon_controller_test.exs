defmodule TopRoleWeb.WeaponControllerTest do
  use TopRoleWeb.ConnCase

  alias TopRole.Resources

  @create_attrs %{ability: %{}, age: "some age", attached_spells: "some attached_spells", axe: true, charges: 42, curse: true, description: "some description", dmg1: "some dmg1", dmg2: "some dmg2", dmg_type: "some dmg_type", firearm: true, name: "some name", page: "some page", property: "some property", range: "some range", rarity: "some rarity", reload: 42, req_attune: "some req_attune", sentient: true, source: "some source", staff: true, sword: true, tier: "some tier", type: "some type", value: "some value", weapon_category: "some weapon_category", weight: "some weight", wondrous: true}
  @update_attrs %{ability: %{}, age: "some updated age", attached_spells: "some updated attached_spells", axe: false, charges: 43, curse: false, description: "some updated description", dmg1: "some updated dmg1", dmg2: "some updated dmg2", dmg_type: "some updated dmg_type", firearm: false, name: "some updated name", page: "some updated page", property: "some updated property", range: "some updated range", rarity: "some updated rarity", reload: 43, req_attune: "some updated req_attune", sentient: false, source: "some updated source", staff: false, sword: false, tier: "some updated tier", type: "some updated type", value: "some updated value", weapon_category: "some updated weapon_category", weight: "some updated weight", wondrous: false}
  @invalid_attrs %{ability: nil, age: nil, attached_spells: nil, axe: nil, charges: nil, curse: nil, description: nil, dmg1: nil, dmg2: nil, dmg_type: nil, firearm: nil, name: nil, page: nil, property: nil, range: nil, rarity: nil, reload: nil, req_attune: nil, sentient: nil, source: nil, staff: nil, sword: nil, tier: nil, type: nil, value: nil, weapon_category: nil, weight: nil, wondrous: nil}

  def fixture(:weapon) do
    {:ok, weapon} = Resources.create_weapon(@create_attrs)
    weapon
  end

  describe "index" do
    test "lists all weapons", %{conn: conn} do
      conn = get(conn, Routes.weapon_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Weapons"
    end
  end

  describe "new weapon" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.weapon_path(conn, :new))
      assert html_response(conn, 200) =~ "New Weapon"
    end
  end

  describe "create weapon" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.weapon_path(conn, :create), weapon: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.weapon_path(conn, :show, id)

      conn = get(conn, Routes.weapon_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Weapon"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.weapon_path(conn, :create), weapon: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Weapon"
    end
  end

  describe "edit weapon" do
    setup [:create_weapon]

    test "renders form for editing chosen weapon", %{conn: conn, weapon: weapon} do
      conn = get(conn, Routes.weapon_path(conn, :edit, weapon))
      assert html_response(conn, 200) =~ "Edit Weapon"
    end
  end

  describe "update weapon" do
    setup [:create_weapon]

    test "redirects when data is valid", %{conn: conn, weapon: weapon} do
      conn = put(conn, Routes.weapon_path(conn, :update, weapon), weapon: @update_attrs)
      assert redirected_to(conn) == Routes.weapon_path(conn, :show, weapon)

      conn = get(conn, Routes.weapon_path(conn, :show, weapon))
      assert html_response(conn, 200) =~ "some updated age"
    end

    test "renders errors when data is invalid", %{conn: conn, weapon: weapon} do
      conn = put(conn, Routes.weapon_path(conn, :update, weapon), weapon: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Weapon"
    end
  end

  describe "delete weapon" do
    setup [:create_weapon]

    test "deletes chosen weapon", %{conn: conn, weapon: weapon} do
      conn = delete(conn, Routes.weapon_path(conn, :delete, weapon))
      assert redirected_to(conn) == Routes.weapon_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.weapon_path(conn, :show, weapon))
      end
    end
  end

  defp create_weapon(_) do
    weapon = fixture(:weapon)
    {:ok, weapon: weapon}
  end
end
