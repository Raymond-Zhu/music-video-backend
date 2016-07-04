defmodule Karaoke.ArtistView do
  use Karaoke.Web, :view

  def render("success.json", %{artists: artists}) do
    %{artists: artists}
  end
end
