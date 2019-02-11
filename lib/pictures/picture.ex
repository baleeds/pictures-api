defmodule Pictures.Picture do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pictures.{
    Picture,
    Gallery
  }

  schema "pictures" do
    field(:name, :string, null: false)
    field(:url, :string, null: false)
    field(:size, :integer, null: false)

    many_to_many(:gallery, Gallery, join_through: "gallery_pictures")
  end

  def changeset(picture, attrs) do
    picture
    |> cast(attrs, [:name, :url, :size])
    |> validate_required([:name, :url, :size])
    |> unique_constraint(:url)
    |> unique_constraint(:name)
    |> validate_length(:name, [min: 3])
  end
end
