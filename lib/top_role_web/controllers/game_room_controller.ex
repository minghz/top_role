defmodule TopRoleWeb.GameRoomController do
  use TopRoleWeb, :controller
  import Phoenix.LiveView.Controller

  def show(conn, %{"room" => room}) do
    case Pow.Plug.current_user(conn) do
      %TopRole.User{} = current_user ->
        live_render(conn, TopRoleWeb.GameRoom, session: %{
          room: room,
          current_user: current_user,
        })
      {:error, _} -> conn
    end
  end
end
