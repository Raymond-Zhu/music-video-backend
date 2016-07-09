defmodule Karaoke.TrackController do
  use Karaoke.Web, :controller
  import Ecto.Query

  def show(conn, %{"artist_id" => artist_id}) do
    tracks = Repo.all(
              from track in Karaoke.Track,
              where: ^artist_id == track.track_artist_id,
              select: track
             )

    conn
    |> put_status(:ok)
    |> render("track.json", tracks: tracks)
  end

  def update(conn, %{"artist_id" => artist_id, "name" => name}) do
    Repo.delete_all(from track in Karaoke.Track, where: track.track_artist_id == ^artist_id)
    tracks = Karaoke.Track.insert_tracks_for(%Karaoke.Artist{id: artist_id, name: name})

    conn
    |> pust_status(:ok)
    |> render("track.json", tracks: tracks)
  end
end
