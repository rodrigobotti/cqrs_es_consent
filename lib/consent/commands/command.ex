defmodule Consent.Command do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto
      import Ecto.Changeset
      alias Consent.Types

      @behaviour Consent.Command


      @derive Jason.Encoder

    end
  end

  @callback changeset(term()) :: Ecto.Changeset.t()

end
