defmodule Karaoke.MusicGraph do
  defp handle_response({:ok, %{status_code: 200, body: body}}), do: body |> Poison.decode! |> Map.fetch!("data")
  defp handle_response({:error, %{reason: reason}}), do: {:error, %{reason: reason}}
  defp handle_response({:ok, %{status_code: code, body: body}}), do: {:error, %{status_code: code, body: body}}

  def get_tracks(name) when is_binary(name) do
    url = Application.get_env(:karaoke, :musicgraph_tracks) <>
          "?api_key=#{Application.get_env(:karaoke, :musicgraph_key)}" <>
          "&artist_name=#{URI.encode(name)}"

    url
    |> HTTPoison.get
    |> handle_response
    |> Map.fetch!("data")
  end
end
