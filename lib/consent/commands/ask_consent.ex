defmodule Consent.Commands.AskConsent do
  @type t :: %__MODULE__{
          patient_id: binary,
          by_id: binary,
          by_entity: Consent.Types.actor(),
          target: Consent.Types.target()
        }

  @derive Jason.Encoder
  defstruct [
    :by_id,
    :by_entity,
    :patient_id,
    :target
  ]
end
