defmodule Karaoke.ArtistView do
  use Karaoke.Web, :view

  def render("artist.json", %{artists: artists}) do
    %{artists: artists}
  end

  def render("success.json", %{tracks: tracks}) do
    %{tracks: tracks}
  end
end
