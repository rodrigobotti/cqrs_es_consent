defmodule Consent.Patient do
  use Timex

  alias __MODULE__
  alias Consent.Events.{ConsentAsked, ConsentGranted, ConsentRevoked}
  alias Consent.Commands.{AskConsent, GrantConsent, RevokeConsent}

  @derive Jason.Encoder
  defstruct consent: %{}

  # execute :: state -> command -> {:ok, [event]} | {:error, reason}

  def execute(%{} = patient, %AskConsent{} = cmd) do
    if has_consent?(patient, {cmd.by_entity, cmd.by_id}, cmd.target) do
      {:error, :consent_already_granted}
    else
      %ConsentAsked{
        patient_id: cmd.patient_id,
        by_id: cmd.by_id,
        by_entity: cmd.by_entity,
        target: cmd.target
      }
      |> add_timestamp()
    end
  end

  def execute(%{} = patient, %GrantConsent{} = cmd) do
    if has_consent?(patient, {cmd.to_entity, cmd.to_id}, cmd.target) do
      {:error, :consent_already_granted}
    else
      %ConsentGranted{
        patient_id: cmd.patient_id,
        to_entity: cmd.to_entity,
        to_id: cmd.to_id,
        target: cmd.target
      }
      |> add_timestamp()
    end
  end

  def execute(%{} = patient, %RevokeConsent{} = cmd) do
    if has_consent?(patient, {cmd.from_entity, cmd.from_id}, cmd.target) do
      %ConsentRevoked{
        patient_id: cmd.patient_id,
        from_entity: cmd.from_entity,
        from_id: cmd.from_id,
        target: cmd.target
      }
      |> add_timestamp()
    else
      {:error, :consent_not_granted}
    end
  end

  # apply :: state -> event -> state

  def apply(%Patient{consent: consent} = patient, %ConsentGranted{
        to_entity: entity,
        to_id: id,
        target: target
      }) do
    consent
    |> Map.get({entity, id}, [])
    |> (&[target | &1]).()
    |> update_consent({entity, id}, consent)
    |> update_patient(patient)
  end

  def apply(%Patient{consent: consent} = patient, %ConsentRevoked{
        from_entity: entity,
        from_id: id,
        target: target
      }) do
    consent
    |> Map.get({entity, id}, [])
    |> List.delete(target)
    |> update_consent({entity, id}, consent)
    |> update_patient(patient)
  end

  def apply(state, _event), do: state

  # private

  defp has_consent?(%{consent: consent}, {entity, id}, target) do
    consent
    |> Map.get({entity, id}, [])
    |> Enum.member?(target)
  end

  defp add_timestamp(event) do
    Map.put(event, :timestamp, Timex.now())
  end

  defp update_consent(target_list, key, %{} = consent_map) do
    Map.put(consent_map, key, target_list)
  end

  defp update_patient(%{} = consent_map, %Patient{} = patient) do
    %Patient{patient | consent: consent_map}
  end
end
