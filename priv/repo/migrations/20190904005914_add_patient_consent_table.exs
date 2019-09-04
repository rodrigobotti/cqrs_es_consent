defmodule Consent.Repo.Migrations.AddPatientConsentTable do
  use Ecto.Migration

  def change do
    create table(:patient_consent) do
      add(:patient_id, :string)
      add(:entity_name, :string)
      add(:entity_id, :string)
      add(:permissions, {:array, :string})
    end
    create unique_index("patient_consent", [:patient_id, :entity_name, :entity_id])
    create index("patient_consent", [:patient_id])
  end
end
