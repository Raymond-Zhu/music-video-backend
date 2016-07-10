defmodule Karaoke.Track do
  use Karaoke.Web, :model

  require Logger

  @derive {Poison.Encoder, except: [:__meta__]}
  @primary_key {:id, :string, []}
  schema "tracks" do
    field :title, :string, default: ""
    field :track_artist_id, :string, default: ""
    field :track_youtube_id, :string, default: ""
    field :artist_name, :string, default: ""
    field :popularity, :float, default: 0.0
    field :album_title, :string, default: ""
    field :image, :string, default: ""
  end

  @required_fields ~w(id title track_artist_id artist_name track_youtube_id)
  @optional_fields ~w(image popularity album_title)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:title)
  end

  def get_tracks_for(%Karaoke.Artist{id: artist_id, name: name})  do
    name
    |> Karaoke.MusicGraph.get_tracks
    |> case do
         {:error, %{reason: reason}} -> {:error, "HTTPoison encountered an error. Reason: #{reason}"}
         {:error, %{status_code: code, body: body}} ->
           {:error, "Could not get tracks for artist.\n" <>
                    "    Status Code: #{code}\n" <>
                    "    Body: #{body}"}

         [] -> []
         list_of_tracks ->
            with valid_tracks <- Enum.filter(list_of_tracks, fn(track) -> Map.get(track, "track_youtube_id") != nil && Map.get(track, "track_artist_id") == artist_id end),
                 album_art <- Karaoke.Spotify.get_album_art(valid_tracks),
            do: {:ok, insert_images(valid_tracks, album_art)}
       end
  end

  def insert_images(list_of_tracks, album_art_map) do
    for track <- list_of_tracks do
      spotify_id = track["track_spotify_id"]
      if album_art_map[spotify_id] != nil do
        Map.put(track, "image", album_art_map[spotify_id])
      else
        Map.put(track, "image", Application.get_env(:karaoke, :youtube_image) <>"#{track["track_youtube_id"]}/0.jpg")
      end
    end
  end
end
