defmodule Karaoke.ArtistController do
  use Karaoke.Web, :controller

  require Logger
  alias Karaoke.Artist
  alias Karaoke.Track

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("artist.json", artists: Repo.all(Artist))
  end

  def create(conn, params) do
    changeset = Artist.changeset(%Artist{}, params)
    tracks = []

    with {:ok, artist} <- Repo.insert(changeset),
         {:ok, list_of_tracks} <- Track.get_tracks_for(artist),
         list_of_entries <- Enum.map(list_of_tracks, fn(track) -> Track.changeset(%Track{}, track) end),
         {:ok, tracks} <- Repo.insert_all(%Track{}, list_of_entries)
    do conn
       |> put_status(:created)
       |> render("success.json", tracks: tracks)
    else
      {:error, error_info} ->  Logger.info"hi"
    end


    #case Repo.insert(changeset) do
      #{:ok, artist} ->
        #case Track.get_tracks_for(artist) do
          #{:error, reason} -> Logger.error(reason)
          #list_of_tracks ->
            #list_of_entries =
            #case Repo.insert_all(%Track{}, list_of_entries) do
              #{:ok, returned_tracks} -> tracks = returned_tracks
              #{:error, _changeset} -> Logger.error "Problem inserting tracks to database for artist #{inspect artist}"
            #end
        #end
      #{:error, changeset} ->
        #conn
        #|> put_status(:unprocessable_entity)
        #|> render(Karaoke.ChangesetView, "error.json", changeset: changeset)
    #end
  end
end
