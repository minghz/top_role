defmodule TopRoleWeb.MouseLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h1 phx-click="boom">The event count is: <%= @val %></h1>
      <button class="btn btn-primary" phx-click="boom" class="alert-danger">BOOM</button>
    </div>

    <div phx-mousemove="testmouse" style="width:500px;height:500px;background-color:#222;">
      <div style="width:4px; height:4px; position:absolute; background-color:white;top: <%= @y %>px; left: <%= @x %>px"
    </div>
    """
  end

  def mount(_session, socket) do
    socket = socket
    |> assign(:val, 0)
    |> assign(:x, 0)
    |> assign(:y, 0)
    {:ok, assign(socket, :val, 0)}
  end

  def handle_event("testmouse", event, socket) do
    socket = socket
    |> update(:val, &(&1 + 1))
    |> assign(:x, event["x"])
    |> assign(:y, event["y"])
    {:noreply, socket}
  end
end
