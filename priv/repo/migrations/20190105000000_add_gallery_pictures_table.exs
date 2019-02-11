defmodule Pictures.Repo.Migrations.AddGalleryPicturesTable do
  use Ecto.Migration

  @table :gallery_pictures

  def change do
    create table(@table) do
      add(:gallery_id, references(:galleries), null: false)
      add(:picture_id, references(:pictures), null: false)
    end

    create(index(@table, [:gallery_id]))
    create(index(@table, [:picture_id]))
  end
end