defmodule Consent.Schemas.Patient do
  use Ecto.Schema

  schema "patient_consent" do
    field(:patient_id, :string)
    field(:entity_name, :string)
    field(:entity_id, :string)
    field(:permissions, {:array, :string})
  end
end
