defmodule TopRole.Repo.Migrations.CreateCharacterSheets do
  use Ecto.Migration

  def change do
    create table(:character_sheets) do
      add :player_id, :integer

      add :level,      :integer
      add :class,      :string
      add :background, :string
      add :race,       :string
      add :alignment,  :string
      add :exp,        :integer

      add :str, :integer
      add :dex, :integer
      add :con, :integer
      add :int, :integer
      add :wiz, :integer
      add :cha, :integer

      add :skills, :map

      add :ac, :integer
      add :speed, :integer
      add :hp, :integer
      add :hp_max, :integer
      add :hp_tmp, :integer
      add :hit_dice, :integer
      add :hit_dice_max, :integer
      add :death_saves, :map

      add :attacks, :map
      add :spellcasting, :map

      add :money, :map
      add :inventory, :map

      timestamps()
    end

  end
end
