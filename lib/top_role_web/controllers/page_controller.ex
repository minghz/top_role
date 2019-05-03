defmodule TopRoleWeb.HomeController do
  use TopRoleWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
