defmodule Pictures.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :name, :string

      timestamps()
    end

  end
end
