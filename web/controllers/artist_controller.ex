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
         {:ok, list_of_tracks} <- Track.get_tracks_for(artist), do

       for track <- list_of_tracks do
         %Track{}
         |> Track.changeset(track)
         |> Repo.insert!
       end

       conn
       |> put_status(:created)
       |> render("success.json", tracks: tracks)
    else
      {:error, error_info} ->  handle_error(error_info)
    end
  end

  defp handle_error(reason) when is_binary(reason) do
    Logger.error "#{reason}"

    conn
    |> put_status(:ok)
    |> render("success.json", tracks: [])
  end
  defp handle_error(changeset) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Karaoke.ChangesetView, "error.json", changeset: changeset)
  end
end
