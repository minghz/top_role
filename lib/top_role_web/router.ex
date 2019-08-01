defmodule TopRoleWeb.Router do
  use TopRoleWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through [:browser]
    pow_routes()
  end

  scope "/", TopRoleWeb do
    pipe_through [:browser]

    get "/", HomeController, :index
    resources "/character_sheets", SheetController
    resources "/items", ItemController
    resources "/weapons", WeaponController

    scope "/" do
      pipe_through [:protected]

      get "/dashboard", DashboardController, :index
      resources "/game_rooms", GameRoomController
      live "/mouse", MouseLive
    end
  end
end
