defmodule Consent.Events.ConsentAsked do
  @type t :: %__MODULE__{
          patient_id: binary,
          by_id: binary,
          by_entity: Consent.Types.actor(),
          target: Consent.Types.target(),
          timestamp: DateTime.t()
        }

  @derive Jason.Encoder
  defstruct [
    :by_id,
    :by_entity,
    :patient_id,
    :target,
    :timestamp
  ]
end
