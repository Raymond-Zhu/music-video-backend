defmodule Karaoke.Repo.Migrations.CreateTrack do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :track_id, :string
      add :title, :string
      add :artist, :string
      add :popularity, :float
      add :youtube_id, :string
      add :album_art, :string

      timestamps
    end

  end
end
