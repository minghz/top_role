defmodule TopRole.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()

    has_many :game_rooms, TopRole.GameRoom

    timestamps()
  end
end
