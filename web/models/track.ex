defmodule Karaoke.Track do
  use Karaoke.Web, :model

  @derive {Poison.Encoder, except: [:id]}
  schema "tracks" do
    field :track_id, :string
    field :title, :string
    field :artist, :string
    field :popularity, :float
    field :youtube_id, :string
    field :album_title, :string
    field :album_art, :string
  end

  @required_fields ~w(title artist youtube_id)
  @optional_fields ~w(album_art popularity track_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint([:title, :youtube_id])
  end
end
