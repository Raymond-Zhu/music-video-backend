defmodule Karaoke.Track do
  use Karaoke.Web, :model

  require Logger

  @derive {Poison.Encoder, except: [:id]}
  schema "tracks" do
    field :track_id, :string
    field :title, :string
    field :artist_name, :string
    field :popularity, :float
    field :track_youtube_id, :string
    field :album_title, :string
    field :album_art, :string
  end

  @required_fields ~w(title artist_name track_youtube_id)
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

  def insert_tracks_for(artist) when is_binary(artist) do
    tracks = artist |> Karaoke.MusicGraph.get_tracks

    case tracks do
      [] -> Logger.error "No tracks were returned for artist #{artist}"
      _ -> Enum.filter_map(tracks, fn(track) -> Map.get(track, "track_youtube_id") != nil end, &insert_track/1)
    end
  end

  defp insert_track(track) do
    changeset = __MODULE__.changeset(%__MODULE__{}, track)

    case Karaoke.Repo.insert(changeset) do
      {:ok, struct} -> :ok
      {:error, changeset} ->
        Logger.error "An error occured while inserting track.\n" <>
                      "Artist: #{track["artist_name"]}\n" <>
                      "Track: #{track["title"]}\n" <>
                      "Error: #{Karaoke.ChangesetView.translate_errors(changeset) |> Poison.encode!}"
    end
  end
end
