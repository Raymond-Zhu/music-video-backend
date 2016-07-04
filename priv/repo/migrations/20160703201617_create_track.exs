defmodule Karaoke.Repo.Migrations.CreateTrack do
  use Ecto.Migration

  def change do
    create table(:tracks, primary_key: false) do
      add :track_id, :string, primary_key: true
      add :title, :string
      add :artist, :string
      add :popularity, :float
      add :youtube_id, :string
      add :album_art, :string
    end

  end
end
