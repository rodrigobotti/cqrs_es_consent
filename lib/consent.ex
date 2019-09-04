defmodule Consent do
  alias Consent.CommandRouter, as: Router
  alias Consent.Commands.{AskConsent, GrantConsent, RevokeConsent}
  alias Consent.Types, as: T

  # Write side

  @spec ask_consent(binary, T.actor(), binary, T.target()) :: :ok | {:error, term()}
  def ask_consent(patient_id, by_entity, by_id, target) do
    %AskConsent{
      patient_id: patient_id,
      by_entity: by_entity,
      by_id: by_id,
      target: target
    }
    |> Router.dispatch()
  end

  @spec grant_consent(binary, T.actor(), binary, T.target()) :: :ok | {:error, term()}
  def grant_consent(patient_id, to_entity, to_id, target) do
    %GrantConsent{
      patient_id: patient_id,
      to_entity: to_entity,
      to_id: to_id,
      target: target
    }
    |> Router.dispatch()
  end

  @spec revoke_consent(binary, T.actor(), binary, T.target()) :: :ok | {:error, term()}
  def revoke_consent(patient_id, from_entity, from_id, target) do
    %RevokeConsent{
      patient_id: patient_id,
      from_entity: from_entity,
      from_id: from_id,
      target: target
    }
    |> Router.dispatch()
  end

  # Read side

end
