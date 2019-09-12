defmodule Consent.Schemas.Patient do
  use Ecto.Schema
  @derive {Jason.Encoder, except: [:__meta__, :__struct__]}
  schema "patient_consent" do
    field(:patient_id, :string)
    field(:entity_name, :string)
    field(:entity_id, :string)
    field(:permissions, {:array, :string})
  end
end
