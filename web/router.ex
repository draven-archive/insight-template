defmodule Insight.Router do
  use Insight.Web, :router

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

  scope "/", Insight do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Insight do
    pipe_through :api

    resources "/users", UserController, except: [:delete, :index]
    resources "/sessions", SessionController, only: [:create]
  end
end
