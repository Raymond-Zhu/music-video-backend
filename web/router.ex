defmodule Karaoke.Router do
  use Karaoke.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Karaoke do
    pipe_through :api

    get "/artist", ArtistController, :index
    get "/artist/:name", ArtistController, :show
  end
end
