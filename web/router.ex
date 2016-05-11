defmodule Talentgrid.Router do
  use Talentgrid.Web, :router

  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug Talentgrid.Admin, repo: Talentgrid.Repo
  end

  scope "/", Talentgrid do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/likes", LikeController, except: [:new, :edit]
    resources "/fb_pages", FbPageController
    resources "/matches", MatchController, only: [:index]
  end

  scope "/", Talentgrid do
    pipe_through [:browser, :admin]
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  scope "/api", Talentgrid do
    pipe_through :api

    resources "/sessions", SessionController, only: [:create, :delete]
    resources "/likes", LikeController, except: [:new, :edit]
  end


  scope "/auth", Talentgrid do
    pipe_through [:browser]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end
end


