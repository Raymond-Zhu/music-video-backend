defmodule Karaoke.Repo.Migrations.CreateArtist do
  use Ecto.Migration

  def change do
    create table(:artists, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string
      add :img_url, :string
    end

    create unique_index(:artists, [:name])
  end
end
