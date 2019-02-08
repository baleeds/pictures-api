defmodule Pictures.Repo.Migrations.AddPicturesTable do
  use Ecto.Migration

  def change do
    create table(:pictures) do
      add(:name, :string, null: false)
      add(:url, :string, null: false)
      add(:size, :integer, null: false)
    end

    create unique_index(:pictures, [:name])
    create unique_index(:pictures, [:url])
  end
end
