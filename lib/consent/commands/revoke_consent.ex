defmodule Consent.Commands.RevokeConsent do
  use Consent.Command

  @type t :: %__MODULE__{
          patient_id: binary,
          from_id: binary,
          from_entity: Consent.Types.actor(),
          target: Consent.Types.target()
        }

  embedded_schema do
    field :patient_id
    field :from_id
    field :from_entity
    field :target
  end

  def changeset(command) do
    %__MODULE__{}
    |> cast(Map.from_struct(command), [:patient_id, :from_id, :from_entity, :target])
    |> validate_required([:patient_id, :from_id, :from_entity, :target])
    |> validate_inclusion(:by_entity, Types.actors())
    |> validate_inclusion(:target, Types.targets())
  end

end
