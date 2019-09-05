defmodule Consent.Projectors.Patient do
  use Commanded.Projections.Ecto, name: to_string(__MODULE__)

  import Ecto.Query

  alias Consent.Events.{ConsentAsked, ConsentGranted, ConsentRevoked}
  alias Consent.Schemas
  alias Consent.Repo

  project(%ConsentAsked{} = evt, fn multi ->
    patient_exists? =
      query_patient(evt.patient_id, evt.by_entity, evt.by_id)
      |> Repo.exists?()

    if patient_exists? do
      multi
    else
      Ecto.Multi.insert(multi, :create_patient_consent, %Schemas.Patient{
        patient_id: evt.patient_id,
        entity_name: evt.by_entity,
        entity_id: evt.by_id,
        permissions: []
      })
    end
  end)

  project(%ConsentGranted{} = evt, fn multi ->
    patient =
      query_patient(evt.patient_id, evt.to_entity, evt.to_id)
      |> Repo.one()

    case patient do
      nil ->
        Ecto.Multi.insert(multi, :create_patient_consent, %Schemas.Patient{
          patient_id: evt.patient_id,
          entity_name: evt.to_entity,
          entity_id: evt.to_id,
          permissions: [evt.target]
        })

      saved ->
        changeset =
          [evt.target | saved.permissions]
          |> update_permissions_changeset(saved)

        Ecto.Multi.update(multi, :update_patient_consent, changeset)
    end
  end)

  project(%ConsentRevoked{} = evt, fn multi ->
    patient =
      query_patient(evt.patient_id, evt.from_entity, evt.from_id)
      |> Repo.one()

    case patient do
      nil ->
        multi

      saved ->
        changeset =
          List.delete(saved.permissions, evt.target)
          |> update_permissions_changeset(saved)

        Ecto.Multi.update(multi, :update_patient_consent, changeset)
    end
  end)

  def update_permissions_changeset(permissions, patient) do
    patient
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_change(:permissions, Enum.uniq(permissions))
  end

  defp query_patient(patient_id, entity_name, entity_id) do
    from(
      p in Schemas.Patient,
      where:
        p.patient_id == ^patient_id and
          p.entity_name == ^entity_name and
          p.entity_id == ^entity_id
    )
  end
end
