defmodule ConsentWeb.ConsentView do
  use ConsentWeb, :view

  def render("consent_success.json", %{patient_id: patient_id, action: action}) do
    %{patient_id: patient_id, action: action}
  end

  def render("list_consent.json", %{list: list}) do
    %{data: list}
  end

  def render("has_consent.json", %{has_consent: has_consent}) do
    %{has_consent: has_consent}
  end
end
