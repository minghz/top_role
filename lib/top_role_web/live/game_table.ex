defmodule TopRoleWeb.GameTable do
  use Phoenix.LiveView
  alias TopRoleWeb.GamePresence
  alias Phoenix.Socket.Broadcast

  def render(assigns) do
    ~L"""
    <div>
      <h1> Hi: <%= @clicks %>
       </h1>
      <button phx-click="inc" class="btn">inc</button>
    </div>
    """
  end

  def handle_info(%Broadcast{event: "presence_diff"}, socket) do
    {:noreply, socket
      |>assign(:users, GamePresence.list(socket.assigns.room))
    }
  end
  
  def handle_info(%Broadcast{event: "clicks_update"},  socket) do
    with {:ok, clicks} <- Redix.command(:redix, ["GET", socket.assigns.room <> "clicks"]) do
      {clicks, _} = Integer.parse(clicks)
      {:noreply, socket
        |>assign(:clicks, clicks)
      }
    end
  end

  def mount(session, socket) do
    room = session.room
    current_user = session.current_user
    TopRoleWeb.Endpoint.subscribe(room)
    {:ok, _} = GamePresence.track(self(), room, current_user.id, %{})
    with {:ok, clicks} <- Redix.command(:redix, ["GET", room <> "clicks"]) do
      clicks = cond do
        clicks == nil ->
          clicks = 0
          {:ok, _} = Redix.command(:redix, ["SET", room <> "clicks", clicks])
          clicks
        true ->
          {clicks, _} = Integer.parse(clicks)
          clicks
      end
      {:ok, socket
        |>assign(:clicks, clicks)
        |>assign(:room, room)
        |>assign(:user, current_user)
        |>assign(:user_id, Integer.to_string(current_user.id))
        |>assign(:users, GamePresence.list(room))
      }
    end
  end

  def handle_event("inc", clicks, socket) do
    with {:ok, clicks} <- Redix.command(:redix, ["GET", socket.assigns.room <> "clicks"]) do
      {clicks, _} = Integer.parse(clicks)
      new_value = clicks + 1
      {:ok, _} = Redix.command(:redix, ["SET", socket.assigns.room <> "clicks", new_value])
      TopRoleWeb.Endpoint.broadcast(socket.assigns.room, "clicks_update", %{})
      {:noreply, socket} # Don't need to update clicks here because the broadcast will update it
    end
  end
end