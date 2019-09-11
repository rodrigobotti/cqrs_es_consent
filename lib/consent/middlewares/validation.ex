defmodule Consent.Middlewares.Validation do
  @behaviour Commanded.Middleware

  alias Commanded.Middleware.Pipeline
  import Pipeline

  def before_dispatch(%Pipeline{command: command} = pipeline) do
    with {:ok, changeset} <- command_changeset(command) do
      if changeset.valid?,
        do: pipeline,
        else: respond_error(pipeline, error_messages(changeset))
    else
      {:error, error} -> respond_error(pipeline, error)
    end
  end

  def after_dispatch(%Pipeline{} = pipeline), do: pipeline

  def after_failure(%Pipeline{} = pipeline), do: pipeline

  defp command_changeset(command) do
    with %command_module{} <- command do
      {:ok, command_module.changeset(command)}
    else
      error -> {:error, error}
    end
  end

  defp respond_error(pipeline, error) do
    pipeline
    |> respond({:error, :validation_error, error})
    |> halt
  end

  defp error_messages(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
