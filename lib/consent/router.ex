defmodule Consent.CommandRouter do
  use Commanded.Commands.Router

  alias Consent.Commands.{AskConsent, GrantConsent, RevokeConsent}

  middleware Commanded.Middleware.Logger
  middleware Consent.Middlewares.Validation

  dispatch(
    [AskConsent, GrantConsent, RevokeConsent],
    to: Consent.Aggregates.Patient,
    identity: :patient_id
  )
end
