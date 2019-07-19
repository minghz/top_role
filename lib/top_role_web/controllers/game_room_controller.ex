defmodule TopRoleWeb.GameRoomController do
  use TopRoleWeb, :controller

  def index(conn, _params) do
    game_rooms = TopRole.Repo.all (TopRole.GameRoom)
    render(conn, "index.html", game_rooms: game_rooms)
  end

  def show(conn, %{"id" => id}) do
    game_room = TopRole.Repo.get(TopRole.GameRoom, id)
    render(conn, "show.html", game_room: game_room)
  end
end
