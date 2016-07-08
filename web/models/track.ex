defmodule Karaoke.Track do
  use Karaoke.Web, :model

  require Logger

  @derive {Poison.Encoder, except: [:__meta__, :id, :track_id]}
  schema "tracks" do
    field :track_id, :string, default: ""
    field :title, :string, default: ""
    field :track_artist_id, :string, default: ""
    field :artist_name, :string, default: ""
    field :popularity, :float, default: 0.0
    field :track_youtube_id, :string, default: ""
    field :album_title, :string, default: ""
    field :album_art, :string, default: ""
  end

  @required_fields ~w(title artist_name track_artist_id track_youtube_id)
  @optional_fields ~w(album_art popularity track_id album_title)

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

  def insert_tracks_for(%Karaoke.Artist{artist_id: artist_id, name: name})  do
    name
    |> Karaoke.MusicGraph.get_tracks
    |> case do
         {:error, %{reason: reason}} -> Logger.error "HTTPoison encountered an error. Reason: #{reason}"
         {:error, %{status_code: code, body: body}} ->
           Logger.error "Could not get tracks for artist.\n" <>
                         "    Status Code: #{code}\n" <>
                         "    Body: #{body}"

         [] -> Logger.error "No tracks were returned for artist: #{name}"
         tracks -> Enum.filter_map(tracks,
                                   fn(track) -> Map.get(track, "track_youtube_id") != nil && Map.get(track, "track_artist_id") == artist_id end,
                                   &insert_track/1)
       end
  end

  defp insert_track(track) do
    changeset = __MODULE__.changeset(%__MODULE__{}, track)
    case Karaoke.Repo.insert(changeset) do
      {:ok, _struct} -> :ok
      {:error, changeset} ->
        Logger.error "An error occured while inserting track.\n" <>
                      "    Artist: #{track["artist_name"]}\n" <>
                      "    Track: #{track["title"]}\n" <>
                      "    Error: #{Karaoke.ChangesetView.translate_errors(changeset) |> Poison.encode!}"
    end
  end
end
