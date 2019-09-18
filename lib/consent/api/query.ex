defmodule Consent.Api.Query do

  alias Consent.Repo
  alias Consent.Schemas.Patient
  import Ecto.Query

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
      list -> list |> has_any?([ to_string(permission), "all" ])
    end
  end

  defp has_any?(list, values) do
    list |> Enum.any?(&(&1 in values))
  end

end
