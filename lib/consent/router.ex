defmodule Consent.CommandRouter do
  use Commanded.Commands.Router

  alias Consent.Commands.{AskConsent, GrantConsent, RevokeConsent}

  dispatch(
    [AskConsent, GrantConsent, RevokeConsent],
    to: Consent.Patient,
    identity: :patient_id
  )
end
