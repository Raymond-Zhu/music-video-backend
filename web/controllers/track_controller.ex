defmodule Karaoke.TrackController do
  use Karaoke.Web, :controller
  import Ecto.Query

  def show(conn, %{"artist" => artist}) do
    tracks = Repo.all(
              from track in Karaoke.Track,
              where: ^artist == track.artist_name,
              select: track
             )

    IO.inspect tracks

    conn
    |> put_status(:ok)
    |> render("track.json", tracks: tracks)
  end
end
