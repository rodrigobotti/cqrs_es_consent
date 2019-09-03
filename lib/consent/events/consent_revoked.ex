defmodule Consent.Events.ConsentRevoked do
  @type t :: %__MODULE__{
          patient_id: binary,
          from_id: binary,
          from_entity: Consent.Types.actor(),
          target: Consent.Types.target(),
          timestamp: DateTime.t()
        }

  @derive Jason.Encoder
  defstruct [
    :patient_id,
    :from_id,
    :from_entity,
    :target,
    :timestamp
  ]
end
