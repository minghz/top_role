defmodule TopRole.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :type, :string
      add :weight, :string
      add :rarity, :string
      add :source, :string
      add :description, :string

      timestamps()
    end

  end
end
