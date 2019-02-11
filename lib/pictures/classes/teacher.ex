defmodule Pictures.Classes.Teacher do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pictures.Classes.Subject

  schema "teachers" do
    field :name, :string

    # default foreign key is current schema name with _id at the end.
    has_many :subjects, Subject

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
