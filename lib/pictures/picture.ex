defmodule Pictures.Picture do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pictures.Picture

  schema "pictures" do
    field(:name, :string, null: false)
    field(:url, :string, null: false)
    field(:size, :integer, null: false)
  end

  def changeset(%Picture{} = picture, attrs) do
    picture
    |> cast(attrs, [:name, :url, :size])
    |> validate_required([:name, :url, :size])
  end
end
