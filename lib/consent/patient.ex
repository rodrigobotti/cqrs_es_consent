defmodule Consent.Patient do
  use Timex

  defstruct consent: %{}

  alias __MODULE__
  alias Consent.Events.{ConsentAsked, ConsentGranted, ConsentRevoked}
  alias Consent.Commands.{AskConsent, GrantConsent, RevokeConsent}

  defguardp has_key?(map, key) when :erlang.is_map_key(key, map)

  defp add_timestamp(event) do
    Map.put(event, :timestamp, Timex.now())
  end

  # execute :: state -> command -> {:ok, [event]} | {:error, reason}

  def execute(%{consent: consent}, %AskConsent{by_entity: entity, by_id: id})
      when has_key?(consent, {entity, id}) do
    {:error, :consent_already_granted}
  end

  def execute(_state, %AskConsent{} = cmd) do
    %ConsentAsked{
      patient_id: cmd.patient_id,
      by_id: cmd.by_id,
      by_entity: cmd.by_entity,
      target: cmd.target || :all
    }
    |> add_timestamp()
  end

  def execute(%{consent: consent}, %GrantConsent{to_entity: entity, to_id: id})
      when has_key?(consent, {entity, id}) do
    {:error, :consent_already_granted}
  end

  def execute(_state, %GrantConsent{} = cmd) do
    %ConsentGranted{
      patient_id: cmd.patient_id,
      to_entity: cmd.to_entity,
      to_id: cmd.to_id,
      target: cmd.target || :all
    }
    |> add_timestamp()
  end

  def execute(%{consent: consent}, %RevokeConsent{from_entity: entity, from_id: id})
      when not has_key?(consent, {entity, id}) do
    {:error, :consent_not_granted}
  end

  def execute(_state, %RevokeConsent{} = cmd) do
    %ConsentRevoked{
      patient_id: cmd.patient_id,
      from_entity: cmd.from_entity,
      from_id: cmd.from_id,
      target: cmd.target || :all
    }
    |> add_timestamp()
  end

  # apply :: state -> event -> state

  def apply(%Patient{consent: consent} = patient, %ConsentGranted{
        to_entity: entity,
        to_id: id,
        target: target
      }) do
    %Patient{
      patient
      | consent: Map.put(consent, {entity, id}, target)
    }
  end

  def apply(%Patient{consent: consent} = patient, %ConsentRevoked{
        from_entity: entity,
        from_id: id
      }) do
    %Patient{
      patient
      | consent: Map.delete(consent, {entity, id})
    }
  end

  def apply(state, _event), do: state
end
