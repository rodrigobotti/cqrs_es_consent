defmodule Consent.Aggregates.Lifespan.PatientLifespan do
  alias Commanded.Aggregates.AggregateLifespan, as: Lifespan
  alias Consent.Events.ConsentAsked
  alias Consent.Events.ConsentGranted

  @behaviour Lifespan

  @impl Lifespan
  def after_event(%ConsentAsked{}), do: :timer.hours(1)
  def after_event(%ConsentGranted{}), do: :stop
  def after_event(_event), do: :infinity

  @impl Lifespan
  def after_command(_command), do: :timer.minutes(5)

  @impl Lifespan
  def after_error(:validation_error), do: :timer.minutes(5)
  def after_error(:consent_already_granted), do: :timer.minutes(5)
  def after_error(:consent_not_granted), do: :timer.minutes(5)
  def after_error(_error), do: :stop
end
