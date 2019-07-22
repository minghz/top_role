defmodule TopRole.CharacterTest do
  use TopRole.DataCase

  alias TopRole.Character

  describe "character_sheets" do
    alias TopRole.Character.Sheet

    @valid_attrs %{player_id: 42}
    @update_attrs %{player_id: 43}
    @invalid_attrs %{player_id: nil}

    def sheet_fixture(attrs \\ %{}) do
      {:ok, sheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Character.create_sheet()

      sheet
    end

    test "list_character_sheets/0 returns all character_sheets" do
      sheet = sheet_fixture()
      assert Character.list_character_sheets() == [sheet]
    end

    test "get_sheet!/1 returns the sheet with given id" do
      sheet = sheet_fixture()
      assert Character.get_sheet!(sheet.id) == sheet
    end

    test "create_sheet/1 with valid data creates a sheet" do
      assert {:ok, %Sheet{} = sheet} = Character.create_sheet(@valid_attrs)
      assert sheet.player_id == 42
    end

    test "create_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Character.create_sheet(@invalid_attrs)
    end

    test "update_sheet/2 with valid data updates the sheet" do
      sheet = sheet_fixture()
      assert {:ok, %Sheet{} = sheet} = Character.update_sheet(sheet, @update_attrs)
      assert sheet.player_id == 43
    end

    test "update_sheet/2 with invalid data returns error changeset" do
      sheet = sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = Character.update_sheet(sheet, @invalid_attrs)
      assert sheet == Character.get_sheet!(sheet.id)
    end

    test "delete_sheet/1 deletes the sheet" do
      sheet = sheet_fixture()
      assert {:ok, %Sheet{}} = Character.delete_sheet(sheet)
      assert_raise Ecto.NoResultsError, fn -> Character.get_sheet!(sheet.id) end
    end

    test "change_sheet/1 returns a sheet changeset" do
      sheet = sheet_fixture()
      assert %Ecto.Changeset{} = Character.change_sheet(sheet)
    end
  end
end
