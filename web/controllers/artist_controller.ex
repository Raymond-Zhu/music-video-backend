defmodule Karaoke.ArtistController do
  use Karaoke.Web, :controller

  def index(conn, _params) do
    artist_list = Repo.all(Karaoke.Artist) |> Poison.encode!

    conn
    |> put_status(:ok)
    |> render("success.json", artists: artist_list)
  end

  def create(conn, %{"name" => name}) do
  end
end
