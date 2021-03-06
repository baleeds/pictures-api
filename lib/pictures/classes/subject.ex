defmodule Pictures.Classes.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pictures.Classes.Teacher

  schema "subjects" do
    field :name, :string
    
    # default foreign key is atom with _id at the end.
    belongs_to :teacher, Teacher

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :teacher_id])
    |> validate_required([:name])
    |> foreign_key_constraint(:teacher_id)
  end
end
