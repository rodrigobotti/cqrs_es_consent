defmodule Consent.CommandRouter do
  use Commanded.Commands.Router

  alias Consent.Commands.{AskConsent, GrantConsent, RevokeConsent}

  middleware Consent.Middlewares.Validation

  dispatch(
    [AskConsent, GrantConsent, RevokeConsent],
    to: Consent.Patient,
    identity: :patient_id
  )
end
