defmodule PicturesWeb.Resolvers.Gallery do
  alias Pictures.{Repo, Gallery}

  def all(_, _, _) do
    {:ok, Repo.all(Gallery)}
  end

  def create(_, %{input: input}, _) do
    %Gallery{}
    |> Gallery.changeset(input)
    |> Repo.insert()
    |> case do
      {:ok, %{id: id}} -> 
        {:ok, %{
          created_gallery_id: id
        }}

      {:error, changeset} ->
        {:error, "creation failed"}
    end
  end
end