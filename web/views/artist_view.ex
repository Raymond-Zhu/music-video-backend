defmodule Karaoke.ArtistView do
  use Karaoke.Web, :view

  def render("artist.json", %{artists: artists}) do
    %{artists: artists}
  end

  def render("success.json", %{success: ok}) do
    %{success: ok}
  end
end
