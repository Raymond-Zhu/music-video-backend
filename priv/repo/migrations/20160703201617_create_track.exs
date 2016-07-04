defmodule Karaoke.Repo.Migrations.CreateTrack do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :track_id, :string
      add :title, :string
      add :artist_name, :string
      add :popularity, :float
      add :track_youtube_id, :string
      add :album_title, :string
      add :album_art, :string
    end

    create unique_index(:tracks, [:title])
  end
end
