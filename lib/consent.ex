defmodule Consent do
  alias Consent.CommandRouter, as: Router
  alias Consent.Commands.{AskConsent, GrantConsent, RevokeConsent}
  alias Consent.Types, as: T
  alias Consent.Repo
  alias Consent.Schemas.Patient
  import Ecto.Query

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

  def consents(patient_id) do
    from(
      p in Patient,
      where: p.patient_id == ^patient_id
    )
    |> Repo.all()
  end

  def has_consent?(patient_id, entity_name, entity_id, permission \\ :all) do
    permissions =
      from(
        p in Patient,
        where:
          p.patient_id == ^patient_id and
            p.entity_name == ^to_string(entity_name) and
            p.entity_id == ^entity_id,
        select: p.permissions
      )
      |> Repo.one()

    case permissions do
      nil -> false
      [] -> false
      list -> list |> has_any?([ to_string(permission), to_string(:all) ])
    end
  end

  defp has_any?(list, values) do
    list |> Enum.any?(&(&1 in values))
  end

end
