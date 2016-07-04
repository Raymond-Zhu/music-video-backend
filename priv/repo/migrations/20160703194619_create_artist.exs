defmodule Karaoke.Repo.Migrations.CreateArtist do
  use Ecto.Migration

  def change do
    create table(:artists, primary_key: false) do
      add :artist_id, :string
      add :name, :string, primary_key: true
      add :img_url, :string
    end
  end
end
