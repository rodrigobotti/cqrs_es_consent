defmodule Consent.Commands.GrantConsent do
  use Consent.Command

  @type t :: %__MODULE__{
          patient_id: binary,
          to_id: binary,
          to_entity: Consent.Types.actor(),
          target: Consent.Types.target()
        }

  embedded_schema do
    field :patient_id
    field :to_id
    field :to_entity
    field :target
  end

  def changeset(command) do
    %__MODULE__{}
    |> cast(Map.from_struct(command), [:patient_id, :to_id, :to_entity, :target])
    |> validate_required([:patient_id, :to_id, :to_entity, :target])
    |> validate_inclusion(:to_entity, Types.actors())
    |> validate_inclusion(:target, Types.targets())
  end

end
