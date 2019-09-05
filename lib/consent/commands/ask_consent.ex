defmodule Consent.Commands.AskConsent do
  use Consent.Commands.Base

  @type t :: %__MODULE__{
          patient_id: binary,
          by_id: binary,
          by_entity: Consent.Types.actor(),
          target: Consent.Types.target()
        }

  embedded_schema do
    field :patient_id
    field :by_id
    field :by_entity
    field :target
  end

  def changeset(command) do
    %__MODULE__{}
    |> cast(Map.from_struct(command), [:patient_id, :by_id, :by_entity, :target])
    |> validate_required([:patient_id, :by_id, :by_entity, :target])
    |> validate_inclusion(:by_entity, Types.actors())
    |> validate_inclusion(:target, Types.targets())
  end

end
