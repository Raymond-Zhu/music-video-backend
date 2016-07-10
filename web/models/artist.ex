defmodule Karaoke.Artist do
  use Karaoke.Web, :model

  @primary_key {:id, :string, []}
  schema "artists" do
    field :name, :string, default: ""
    field :img_url, :string, default: ""
  end

  @required_fields ~w(name id)
  @optional_fields ~w(img_url)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:name)
  end
end
