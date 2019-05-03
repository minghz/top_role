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

  scope "/", TopRoleWeb do
    pipe_through :browser

    get "/", HomeController, :index
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", TopRoleWeb do
    pipe_through :protected

    live "/mouse", MouseLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", TopRoleWeb do
  #   pipe_through :api
  # end
end
