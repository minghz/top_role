defmodule TopRoleWeb.GameRoomSchemaTest do
  use TopRoleWeb.ConnCase

  test "game_room must have a user_id" do
    changeset = TopRole.GameRoom.changeset(%TopRole.GameRoom{}, %{})

    assert changeset.errors == [user_id: {"can't be blank", [validation: :required]}]
  end
  
  test "user has many game_rooms" do
    user = TopRole.Repo.insert!(%TopRole.Users.User{email: "dummy@example.com"})

    TopRole.Repo.insert!(%TopRole.GameRoom{user_id: user.id, description: "game room 1"})
    TopRole.Repo.insert!(%TopRole.GameRoom{user_id: user.id, description: "game room 2"})

    game_rooms = TopRole.Repo.all Ecto.assoc(user, :game_rooms)

    assert length(game_rooms) == 2
  end

  test "game_room belongs to a user" do
    user = TopRole.Repo.insert!(%TopRole.Users.User{email: "dummy@example.com"})
    game_room = TopRole.Repo.insert!(%TopRole.GameRoom{user_id: user.id, description: "game room 1"})

    associated_user = TopRole.Repo.one! Ecto.assoc(game_room, :user)

    assert associated_user == user
  end

end
