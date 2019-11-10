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
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", NotatwitterWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/auth", NotatwitterWeb.Auth do
    pipe_through :api

    post "/login", SessionController, :login
    get "/session", SessionController, :session

    pipe_through :ensure_auth

    get "/asdf", SessionController, :asdf
  end
end
