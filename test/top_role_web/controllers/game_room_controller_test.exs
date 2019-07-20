defmodule TopRoleWeb.GameRoomControllerTest do
  use TopRoleWeb.ConnCase

  setup %{conn: conn} do
    user = %TopRole.User{email: "test@example.com"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :my_app)

    {:ok, conn: conn}
  end

  test "GET /game_rooms exists", %{conn: conn} do
    conn = get conn, "/game_rooms"
    assert html_response(conn, 200) =~ "Listing all Game Rooms"
  end

  test "GET /game_rooms has no rooms", %{conn: conn} do
    conn = get conn, "/game_rooms"
    assert html_response(conn, 200) =~ "Sorry, no game rooms exist"
  end

  test "GET /game_rooms has a room", %{conn: conn} do
    room = %TopRole.GameRoom{description: "dummy room"}
    TopRole.Repo.insert(room)

    conn = get conn, "/game_rooms"
    assert html_response(conn, 200) =~ "dummy room"
  end

  test "GET /game_rooms has 2 rooms", %{conn: conn} do
    room_1 = %TopRole.GameRoom{description: "dummy room 1"}
    room_2 = %TopRole.GameRoom{description: "dummy room 2"}
    TopRole.Repo.insert(room_1)
    TopRole.Repo.insert(room_2)

    conn = get conn, "/game_rooms"
    assert html_response(conn, 200) =~ "dummy room 1"
    assert html_response(conn, 200) =~ "dummy room 2"
  end

  test "GET /game_rooms/:id", %{conn: conn} do
    conn = get conn, "/game_rooms/2"
    assert html_response(conn, 200) =~ "Showing one game room"
  end
end
