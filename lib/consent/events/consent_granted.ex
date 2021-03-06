defmodule Consent.Events.ConsentGranted do
  @type t :: %__MODULE__{
          patient_id: binary,
          to_id: binary,
          to_entity: Consent.Types.actor(),
          target: Consent.Types.target(),
          timestamp: DateTime.t()
        }

  @derive Jason.Encoder
  defstruct [
    :patient_id,
    :to_id,
    :to_entity,
    :target,
    :timestamp
  ]
end
