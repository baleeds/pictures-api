defmodule PicturesWeb.Resolvers.Picture do
  alias Pictures.{Repo, Picture}

  def all(_, _, _) do
    {:ok, Repo.all(Picture)}
  end

  def delete(_, %{id: id}, _) do
    Picture
    |> Repo.get(id)
    |> case do
      nil ->
        {:error, "picture with id #{id} not found"}

      %Picture{} = picture ->
        picture
        |> Repo.delete()
        |> case do
          {:ok, %{id: id}} ->
            {:ok,
             %{
               deleted_picture_id: id
             }}

          {:error, changeset} ->
            {:error, transform_errors(changeset)}
        end
    end
  end

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn
      {key, value} ->
        %{key: key, message: value}
    end)
  end

  @spec format_error(Ecto.Changeset.error()) :: String.t()
  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
