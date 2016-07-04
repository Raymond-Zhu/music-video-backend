defmodule Karaoke.MusicGraph.Api do
  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    body
    |> Poison.decode!
    |> Map.fetch!("data")
  end

  def get_artist(name) do
    url = Application.get_env(:karaoke, :musicgraph_artist) <>
          "?api_key=#{Application.get_env(:karaoke, :musicgraph_key)}" <>
          "&prefix=#{URI.encode(name)}"
    IO.puts url
    url
    |> HTTPoison.get
    |> handle_response
  end
end
