defmodule TopRole.Resources.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :description, :string
    field :name, :string
    field :rarity, :string
    field :source, :string
    field :type, :string
    field :weight, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :type, :weight, :rarity, :source, :description])
    |> validate_required([:name, :type, :weight, :rarity, :source, :description])
  end
end
