defmodule Karaoke.ArtistController do
  use Karaoke.Web, :controller

  alias Karaoke.Artist

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("artist.json", artists: Repo.all(Artist))
  end

  def show(conn, %{"name" => name}) do
    artist_results = name |> Karaoke.MusicGraph.get_artist

    conn
    |> put_status(:ok)
    |> render("artist.json", artists: artist_results)
  end

  def create(conn, params) do
    changeset = Artist.changeset(%Artist{}, params)

    case Repo.insert(changeset) do
      {:ok, struct} ->
        struct.name |> Karaoke.Track.insert_tracks_for

        conn
        |> put_status(:created)
        |> render("success.json", success: "ok")
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Karaoke.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
