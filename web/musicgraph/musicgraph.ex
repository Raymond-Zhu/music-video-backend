defmodule Karaoke.MusicGraph do
  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    body
    |> Poison.decode!
    |> Map.fetch!("data")
  end

  def get_artist(name) when is_binary(name) do
    url = Application.get_env(:karaoke, :musicgraph_artist) <>
          "?api_key=#{Application.get_env(:karaoke, :musicgraph_key)}" <>
          "&prefix=#{URI.encode(name)}"
    url
    |> HTTPoison.get
    |> handle_response
  end

  def get_tracks(artist) when is_binary(artist) do
    url = Application.get_env(:karaoke, :musicgraph_tracks) <>
          "?api_key=#{Application.get_env(:karaoke, :musicgraph_key)}" <>
          "&artist_name=#{URI.encode(artist)}"

    url
    |> HTTPoison.get
    |> handle_response
  end
end
