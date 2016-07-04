defmodule Karaoke.TrackView do
  use Karaoke.Web, :view

  def render("track.json", %{tracks: tracks}) do
    %{tracks: tracks}
  end
end
