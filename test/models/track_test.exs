defmodule Karaoke.TrackTest do
  use Karaoke.ModelCase

  alias Karaoke.Track

  @valid_attrs %{album_art: "some content", artist: "some content", popularity: "120.5", title: "some content", track_id: "some content", youtube_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Track.changeset(%Track{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Track.changeset(%Track{}, @invalid_attrs)
    refute changeset.valid?
  end
end
