defmodule Consent.EventHandlers.NotifyPatient do
  use Commanded.Event.Handler,
    name: __MODULE__,
    start_from: :current

  alias Consent.Events.ConsentAsked
  alias Commanded.Event.FailureContext

  require Logger

  @max_retry_attempts 3

  def handle(
        %ConsentAsked{
          by_entity: entity,
          by_id: id,
          patient_id: patient_id,
          target: permission
        },
        _meta
      ) do
    with {:ok, patient} <- get_patient_contact(patient_id),
         {:ok, practitioner} <- get_practitioner_contact(entity, id),
         message <- build_message(patient, practitioner, permission),
         :ok <- send_message(patient.phone, message) do
      :ok
    end
  end

  def error({:error, _reason}, %ConsentAsked{} = event, %FailureContext{context: context}) do
    context = record_failure(context)

    case Map.get(context, :failures) do
      too_many when too_many >= @max_retry_attempts ->
        # skip bad event after third failure
        Logger.warn(fn -> "Skipping bad event, too many failures: #{inspect(event)}" end)
        :skip

      _ ->
        # retry event, failure count is included in context map
        {:retry, context}
    end
  end

  defp record_failure(context) do
    Map.update(context, :failures, 1, fn failures -> failures + 1 end)
  end

  defp send_message(phone, message) do
    Logger.info(fn -> "to: #{phone}\nbody: #{message}" end)
    :ok
  end

  defp build_message(patient, practitioner, permission) do
    """
    Hello #{patient.name}.
    #{practitioner.kind} #{practitioner.name} is asking permission to access you #{permission}.
    """
  end

  defp get_patient_contact(patient_id) do
    # should be fetched from other service
    {
      :ok,
      %{
        name: "Super #{patient_id}",
        phone: "+55 00 0000 00000"
      }
    }
  end

  defp get_practitioner_contact(entity, id) do
    # should be fetched from other service
    {
      :ok,
      %{
        name: "Master #{id}",
        kind: entity
      }
    }
  end
end
