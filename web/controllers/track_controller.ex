defmodule Karaoke.TrackController do
  use Karaoke.Web, :controller
  import Ecto.Query

  def show(conn, %{"artist_id" => artist_id}) do
    tracks = Repo.all(
              from track in Karaoke.Track,
              where: ^artist_id == track.artist_id,
              select: track
             )

    conn
    |> put_status(:ok)
    |> render("track.json", tracks: tracks)
  end
end
