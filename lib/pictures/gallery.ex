defmodule Pictures.Gallery do
  use Ecto.Schema
  import Ecto.Changeset
  
  schema "galleries" do
    field(:name, :string, null: false)
    field(:description, :string)
  end

  def changeset(gallery, attrs) do
    gallery
    |> cast(attrs, [
      :name,
      :description
    ])
    |> validate_required([:name])
  end
end