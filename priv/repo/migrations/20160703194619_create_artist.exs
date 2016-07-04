defmodule Karaoke.Repo.Migrations.CreateArtist do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :artist_id, :string
      add :name, :string
      add :img_url, :string
    end

  end
end
