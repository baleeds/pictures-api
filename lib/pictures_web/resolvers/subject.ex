defmodule PicturesWeb.Resolvers.Subject do
  alias Pictures.{Classes}

  def all(_, _, _) do
    {:ok, Classes.list_subjects()}
  end

  def create(_, %{input: create_subject_input}, _) do
    create_subject_input
    |> IO.inspect
    |> Classes.create_subject
    |> IO.inspect
    |> case do
      {:ok, %{id: id}} -> {:ok, %{
        created_subject_id: id
      }}
      
      {:error, changeset} ->
        {:error, transform_errors(changeset)}
    end
  end

  def delete(_, %{input: %{id: id}}, _) do
    id
    |> Classes.get_subject!
    |> IO.inspect
    |> case do
      {:error, _} ->
        {:error, "subject with id #{id} not found"}

      %Classes.Subject{} = subject ->
        subject
        |> IO.inspect
        |> Classes.delete_subject
        |> case do
          {:ok, %{id: id}} ->
            {:ok,
             %{
               deleted_subject_id: id
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
