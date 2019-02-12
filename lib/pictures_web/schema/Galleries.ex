defmodule PicturesWeb.Schema.Galleries do
  use Absinthe.Schema.Notation

  alias PicturesWeb.Resolvers.{
    Picture,
    Gallery
  }
  
  object :galleries_queries do
    field :pictures, non_null(list_of(non_null(:picture))) do
      resolve(&Picture.all/3)
    end

    field :galleries, list_of(non_null(:gallery)) do
      resolve(&Gallery.all/3)
    end
  end

  object :galleries_mutations do
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

    field :create_gallery, :create_gallery_payload do
      arg(:input, non_null(:create_gallery_input))

      resolve(&Gallery.create/3)
    end
  end

  object :picture do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:url, non_null(:string))
    field(:size, non_null(:integer))
    field(:gallery, :gallery) do
      resolve(&Gallery.first/3)
    end
  end

  object :gallery do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:description, :string)
  end

  object :create_picture_payload do
    field(:created_picture_id, non_null(:id))
  end

  input_object :create_gallery_input do
    field(:name, non_null(:string))
    field(:description, :string)
  end

  object :create_gallery_payload do
    field(:created_gallery_id, non_null(:id))
  end

  object :delete_picture_payload do
    field(:deleted_picture_id, non_null(:id))
  end
end
