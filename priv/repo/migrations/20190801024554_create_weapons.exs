defmodule TopRole.Repo.Migrations.CreateWeapons do
  use Ecto.Migration

  def change do
    create table(:weapons) do
      add :name, :string
      add :dmg1, :string
      add :dmg2, :string
      add :dmg_type, :string
      add :description, :string
      add :page, :integer
      add :property, :string
      add :rarity, :string
      add :source, :string
      add :type, :string
      add :weapon_category, :string
      add :weight, :string
      add :attached_spells, :string
      add :curse, :boolean, default: false, null: false
      add :range, :string
      add :req_attune, :boolean
      add :sentient, :boolean, default: false, null: false
      add :tier, :string
      add :charges, :integer
      add :staff, :boolean, default: false, null: false
      add :ability, :map
      add :value, :string
      add :wondrous, :boolean, default: false, null: false
      add :age, :string
      add :firearm, :boolean, default: false, null: false
      add :reload, :integer
      add :axe, :boolean, default: false, null: false
      add :sword, :boolean, default: false, null: false

      timestamps()
    end

  end
end
