defmodule PicturesWeb.Schema do
  use Absinthe.Schema

  alias PicturesWeb.Resolvers.{
    Picture,
    Gallery,
    Teacher,
    Subject
  }

  alias Pictures.Classes
  # alias Absinthe.Middleware.Dataloader
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  
  query do
    field :pictures, non_null(list_of(non_null(:picture))) do
      resolve(&Picture.all/3)
    end

    field :galleries, list_of(non_null(:gallery)) do
      resolve(&Gallery.all/3)
    end

    field :teachers, list_of(non_null(:teacher)) do
      resolve(&Teacher.all/3)
    end

    field :subjects, list_of(non_null(:subject)) do
      resolve(&Subject.all/3)
    end
  end

  mutation do
    field :create_subject, :create_subject_payload do
      arg(:input, non_null(:create_subject_input))

      resolve(&Subject.create/3)
    end

    field :delete_subject, :delete_subject_payload do
      arg(:input, non_null(:delete_subject_input))

      resolve(&Subject.delete/3)
    end

    field :update_subject, :update_subject_payload do
      arg(:input, non_null(:update_subject_input))

      resolve(&Subject.update/3)
    end

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

  object :teacher do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:subjects, list_of(:subject), resolve: dataloader(Classes.Subject))
  end

  object :subject do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:teacher, :teacher, resolve: dataloader(Classes.Teacher))
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

  input_object :create_subject_input do
    field(:name, non_null(:string))
    field(:teacher_id, :id)
  end

  object :create_subject_payload do
    field(:created_subject_id, non_null(:id))
  end

  input_object :delete_subject_input do
    field(:id, non_null(:id))
  end

  object :delete_subject_payload do
    field(:deleted_subject_id, non_null(:id))
  end

  input_object :update_subject_input do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:teacher_id, :id)
  end

  object :update_subject_payload do
    field(:updated_subject_id, non_null(:id))
  end

  object :delete_picture_payload do
    field(:deleted_picture_id, non_null(:id))
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

  def context(ctx) do
    loader =
      Dataloader.new
      |> Dataloader.add_source(Classes.Subject, Classes.data())
      |> Dataloader.add_source(Classes.Teacher, Classes.data()) # Foo source could be a Redis source

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
