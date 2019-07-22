defmodule TopRole.Character.Sheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "character_sheets" do
    field :player_id, :integer

    field :level,      :integer
    field :class,      :string
    field :background, :string
    field :race,       :string
    field :alignment,  :string
    field :exp,        :integer

    field :str, :integer
    field :dex, :integer
    field :con, :integer
    field :int, :integer
    field :wiz, :integer
    field :cha, :integer

    field :skills, :map

    field :ac,           :integer
    field :speed,        :integer
    field :hp,           :integer
    field :hp_max,       :integer
    field :hp_tmp,       :integer
    field :hit_dice,     :integer
    field :hit_dice_max, :integer
    field :death_saves,  :map

    field :attacks,      :map
    field :spellcasting, :map

    field :money,     :map
    field :inventory, :map

    timestamps()
  end

  @doc false
  def changeset(sheet, attrs) do
    sheet
    |> cast(attrs, [:player_id])
    |> validate_required([:player_id])
  end
end
