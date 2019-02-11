defmodule Pictures.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  @table :subjects

  def change do
    create table(@table) do
      add :name, :string
      add :teacher_id, references(:teachers), null: false

      timestamps()
    end

    create(index(@table, [:name]))
    create(index(@table, [:teacher_id]))
  end
end
