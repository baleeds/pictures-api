defmodule Pictures.Gallery do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto

  alias Pictures.{Picture, Repo}
  
  schema "galleries" do
    field(:name, :string, null: false)
    field(:description, :string)

    has_many(:pictures, Picture)
  end

  def get(picture: picture) do
    picture
    |> assoc(:gallery)
    |> Repo.all
  end

  def get(gallery_id) do
    __MODULE__
    |> Repo.get!(__MODULE__, gallery_id)
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