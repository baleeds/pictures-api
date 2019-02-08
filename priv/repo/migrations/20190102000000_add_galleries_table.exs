defmodule Pictures.Repo.Migrations.AddGalleriesTable do
  use Ecto.Migration

  def change do
    create table(:galleries) do
      add(:name, :string, null: false)
      add(:description, :string)
    end

    create unique_index(:galleries, [:name])
  end
end
