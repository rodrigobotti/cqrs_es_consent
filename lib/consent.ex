defmodule Consent do
  alias Consent.Api.Commands
  alias Consent.Api.Query

  defdelegate ask_consent(patient_id, by_entity, by_id, target), to: Commands
  defdelegate grant_consent(patient_id, to_entity, to_id, target), to: Commands
  defdelegate revoke_consent(patient_id, from_entity, from_id, target), to: Commands

  defdelegate consents(patient_id), to: Query
  defdelegate has_consent?(patient_id, entity_name, entity_id, permission \\ :all), to: Query

end
