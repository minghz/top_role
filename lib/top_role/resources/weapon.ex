defmodule TopRole.Resources.Weapon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weapons" do
    field :ability, :map
    field :age, :string
    field :attached_spells, :string
    field :axe, :boolean, default: false
    field :charges, :integer
    field :curse, :boolean, default: false
    field :description, :string
    field :dmg1, :string
    field :dmg2, :string
    field :dmg_type, :string
    field :firearm, :boolean, default: false
    field :name, :string
    field :page, :integer
    field :property, :string
    field :range, :string
    field :rarity, :string
    field :reload, :integer
    field :req_attune, :boolean
    field :sentient, :boolean, default: false
    field :source, :string
    field :staff, :boolean, default: false
    field :sword, :boolean, default: false
    field :tier, :string
    field :type, :string
    field :value, :string
    field :weapon_category, :string
    field :weight, :string
    field :wondrous, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(weapon, attrs) do
    weapon
    |> cast(attrs, [:name, :dmg1, :dmg2, :dmg_type, :description, :page, :property, :rarity, :source, :type, :weapon_category, :weight, :attached_spells, :curse, :range, :req_attune, :sentient, :tier, :charges, :staff, :ability, :value, :wondrous, :age, :firearm, :reload, :axe, :sword])
    |> validate_required([:name, :dmg1, :dmg2, :dmg_type, :description, :page, :property, :rarity, :source, :type, :weapon_category, :weight, :attached_spells, :curse, :range, :req_attune, :sentient, :tier, :charges, :staff, :ability, :value, :wondrous, :age, :firearm, :reload, :axe, :sword])
  end
end
