defmodule PicturesWeb.Schema do
  use Absinthe.Schema

  alias PicturesWeb.Resolvers.Picture

  query do
    field :pictures, non_null(list_of(non_null(:picture))) do
      resolve(&Picture.all/3)
    end
  end

  mutation do
    field :delete_picture, :delete_picture_payload do
      arg(:id, non_null(:id))

      resolve(&Picture.delete/3)
    end

    field :create_picture, :create_picture_payload do
      arg(:name, non_null(:string))
      arg(:url, non_null(:string))
      arg(:size, non_null(:integer))

      resolve(&Picture.create/3)
    end
  end

  object :picture do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:url, non_null(:string))
    field(:size, non_null(:integer))
  end

  object :delete_picture_payload do
    field(:deleted_picture_id, non_null(:id))
  end

  object :create_picture_payload do
    field(:created_picture_id, non_null(:id))
  end
end
