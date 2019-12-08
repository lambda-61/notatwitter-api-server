defmodule NotatwitterWeb.Router do
  use NotatwitterWeb, :router

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

  scope "/", NotatwitterWeb do
    pipe_through [:api, :ensure_auth]

    resources "/users", UserController, only: [:index, :show, :create, :update] do
      get "/posts", PostController, :index
      get "/follows", FollowingController, :follows
      get "/followers", FollowingController, :followers
      post "/follow", FollowingController, :follow
      delete "/unfollow", FollowingController, :unfollow
    end

    resources "/posts", PostController, only: [:create, :update] do
      resources "/replies", ReplyController, only: [:index, :create]
    end

    resources "/replies", ReplyController, only: [:update]
  end

  scope "/auth", NotatwitterWeb.Auth do
    pipe_through :api

    post "/login", SessionController, :login
    post "/register", RegistrationController, :register

    pipe_through :ensure_auth

    get "/session", SessionController, :session
  end

  scope "/dev" do
    forward "/swagger", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :notatwitter,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "EcomWidgetApp"
      }
    }
  end
end
