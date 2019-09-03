defmodule Consent.Commands.RevokeConsent do
  @type t :: %__MODULE__{
          patient_id: binary,
          from_id: binary,
          from_entity: Consent.Types.actor(),
          target: Consent.Types.target()
        }

  @derive Jason.Encoder
  defstruct [
    :patient_id,
    :from_id,
    :from_entity,
    :target
  ]
end
