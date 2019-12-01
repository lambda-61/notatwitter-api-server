defmodule NotatwitterWeb.Router do
  use NotatwitterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :put_secure_browser_headers
    plug Notatwitter.Auth.Guardian.Pipeline
    plug ProperCase.Plug.SnakeCaseParams
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/users", NotatwitterWeb do
    pipe_through [:api, :ensure_auth]

    resources "/", UserController, only: [:index, :show, :create, :update] do
      resources "/posts", PostController, only: [:index, :create, :update] do
        resources "/replies", ReplyController, only: [:index, :create, :update]
      end

      get "/follows", FollowingController, :follows
      get "/followers", FollowingController, :followers
      post "/follow", FollowingController, :follow
      delete "/unfollow", FollowingController, :unfollow
    end
  end

  scope "/auth", NotatwitterWeb.Auth do
    pipe_through :api

    post "/login", SessionController, :login
    post "/register", RegistrationController, :register

    pipe_through :ensure_auth

    get "/session", SessionController, :session
  end
end
