defmodule Karaoke.Spotify do
  defp handle_response({:ok, %{status_code: 200, body: body}}), do: body |> Poison.decode! |> Map.fetch!("tracks")
  defp handle_response({:error, %{reason: reason}}), do: {:error, %{reason: reason}}
  defp handle_response({:ok, %{status_code: code, body: body}}), do: {:error, %{status_code: code, body: body}}

  defp concat_ids(list_of_tracks) do
    list_of_tracks
    |> Enum.filter(fn(track) -> track["track_spotify_id"] != nil end)
    |> case do
        [] -> nil
        tracks ->
          Enum.reduce(tracks, "",
                      fn(%{"track_spotify_id" => id}, acc) ->
                        if acc != "" do
                          acc <> "," <> id
                        else
                          acc <> id
                        end
                      end)
      end
  end

  def get_album_art(list_of_tracks) do
    case list_of_tracks |> concat_ids do
      nil -> %{}
      ids ->
        url = Application.get_env(:karaoke, :spotify_tracks) <>
              "?ids=#{ids}"

        url
        |> HTTPoison.get
        |> handle_response
    end

  end
end
