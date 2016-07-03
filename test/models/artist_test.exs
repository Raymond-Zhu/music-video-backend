defmodule Karaoke.ArtistTest do
  use Karaoke.ModelCase

  alias Karaoke.Artist

  @valid_attrs %{artist_id: "some content", img_url: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Artist.changeset(%Artist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Artist.changeset(%Artist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
