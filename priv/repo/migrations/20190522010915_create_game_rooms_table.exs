defmodule TopRole.Repo.Migrations.CreateGameRoomsTable do
  use Ecto.Migration

  def change do

    create table("game_rooms") do
      add :owner_id, references(:users)
      add :description, :string

      timestamps()
    end

    create index("game_rooms", [:owner_id])

  end
end
