defmodule Karaoke.Track do
  use Karaoke.Web, :model

  schema "tracks" do
    field :track_id, :string
    field :title, :string
    field :artist, :string
    field :popularity, :float
    field :youtube_id, :string
    field :album_art, :string

    timestamps
  end

  @required_fields ~w(track_id title artist popularity youtube_id album_art)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
