defmodule Karaoke.Router do
  use Karaoke.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Karaoke do
    pipe_through :api

    get "/artist", ArtistController, :index
    get "/artist/get", ArtistController, :show
    post "/artist/add", ArtistController, :create

    get "/track", TrackController, :show
  end
end
