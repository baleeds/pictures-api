defmodule PicturesWeb.Schema.Classes do
  use Absinthe.Schema.Notation

  alias PicturesWeb.Resolvers.{
    Teacher,
    Subject
  }

  alias Pictures.Classes
  # alias Absinthe.Middleware.Dataloader
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :classes_queries do
    field :teachers, list_of(non_null(:teacher)) do
      resolve(&Teacher.all/3)
    end

    field :subjects, list_of(non_null(:subject)) do
      resolve(&Subject.all/3)
    end
  end

  object :classes_mutations do
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
end
