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
    list_of_tracks = Karaoke.Track.get_tracks_for(%Karaoke.Artist{id: artist_id, name: name})

    list_of_tracks =
      for track <- list_of_tracks do
        %Track{}
        |> Track.changeset(track)
        |> Repo.insert!
      end

    conn
    |> put_status(:ok)
    |> render("track.json", tracks: list_of_tracks)
  end
end
