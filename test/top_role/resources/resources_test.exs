defmodule TopRole.ResourcesTest do
  use TopRole.DataCase

  alias TopRole.Resources

  describe "items" do
    alias TopRole.Resources.Item

    @valid_attrs %{description: "some description", name: "some name", rarity: "some rarity", source: "some source", type: "some type", weight: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", rarity: "some updated rarity", source: "some updated source", type: "some updated type", weight: 43}
    @invalid_attrs %{description: nil, name: nil, rarity: nil, source: nil, type: nil, weight: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Resources.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Resources.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Resources.create_item(@valid_attrs)
      assert item.description == "some description"
      assert item.name == "some name"
      assert item.rarity == "some rarity"
      assert item.source == "some source"
      assert item.type == "some type"
      assert item.weight == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Resources.update_item(item, @update_attrs)
      assert item.description == "some updated description"
      assert item.name == "some updated name"
      assert item.rarity == "some updated rarity"
      assert item.source == "some updated source"
      assert item.type == "some updated type"
      assert item.weight == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_item(item, @invalid_attrs)
      assert item == Resources.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Resources.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Resources.change_item(item)
    end
  end
end
