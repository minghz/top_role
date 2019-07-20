defmodule TopRole.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()

    has_many :game_rooms, TopRole.GameRoom, foreign_key: :owner_id, references: :id

    timestamps()
  end
end
