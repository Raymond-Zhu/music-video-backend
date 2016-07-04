defmodule Karaoke.Artist do
  use Karaoke.Web, :model

  @primary_key {:artist_id, :string, []}
  @derive {Poison.Encoder, only: [:name, :img_url]}
  schema "artists" do
    field :artist_id, :string
    field :name, :string
    field :img_url, :string
  end

  @required_fields ~w(name)
  @optional_fields ~w(artist_id img_url)

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
