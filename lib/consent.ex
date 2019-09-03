defmodule Consent do
  alias Consent.CommandRouter, as: Router
  alias Consent.Commands.{AskConsent, GrantConsent, RevokeConsent}

  def ask_consent_doctor(patient_id, target, doctor_id) do
    ask_consent(patient_id, target, {:doctor, doctor_id})
  end

  def ask_consent_nurse(patient_id, target, nurse_id) do
    ask_consent(patient_id, target, {:nurse, nurse_id})
  end

  def ask_consent_patient(patient_id, target, other_patient_id) do
    ask_consent(patient_id, target, {:patient, other_patient_id})
  end

  defp ask_consent(patient_id, target, {entity, entity_id}) do
    %AskConsent{
      patient_id: patient_id,
      by_entity: entity,
      by_id: entity_id,
      target: target
    }
    |> Router.dispatch()
  end
end
