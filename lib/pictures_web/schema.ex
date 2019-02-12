defmodule PicturesWeb.Schema do
  use Absinthe.Schema

  alias Pictures.Classes

  import_types(__MODULE__.Classes)
  import_types(__MODULE__.Galleries)

  query do
    import_fields(:classes_queries)
    import_fields(:galleries_queries)
  end

  mutation do
    import_fields(:classes_mutations)
    import_fields(:galleries_mutations)
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
