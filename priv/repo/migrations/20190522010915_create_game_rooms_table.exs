defmodule TopRole.Repo.Migrations.CreateGameRoomsTable do
  use Ecto.Migration

  def change do

    create table("game_rooms") do
      add :user_id, references(:users)
      add :description, :string

      timestamps()
    end

    create index("game_rooms", [:user_id])

  end
end
