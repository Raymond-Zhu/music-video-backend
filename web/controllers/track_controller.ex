defmodule Karaoke.TrackController do
  use Karaoke.Web, :controller
  import Ecto.Query

  def show(conn, %{"artist_id" => id}) do
    tracks = Repo.all(
              from track in Karaoke.Track,
              where: ^id == track.track_artist_id,
              select: track
             )

    conn
    |> put_status(:ok)
    |> render("track.json", tracks: tracks)
  end
end
