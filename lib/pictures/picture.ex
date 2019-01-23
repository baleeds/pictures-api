defmodule Pictures.Picture do
  use Ecto.Schema

  schema "pictures" do
    field(:name, :string, null: false)
    field(:url, :string, null: false)
    field(:size, :integer, null: false)
  end
end
