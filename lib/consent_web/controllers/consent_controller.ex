defmodule ConsentWeb.ConsentController do
  use ConsentWeb, :controller

  action_fallback ConsentWeb.FallbackController

  alias Consent.Api, as: ConsentApi

  def ask_consent(conn, %{
        "patient_id" => patient_id,
        "by_entity" => by_entity,
        "by_id" => by_id,
        "target" => target
      }) do
    with :ok <- ConsentApi.ask_consent(patient_id, by_entity, by_id, target) do
      conn
      |> put_status(:ok)
      |> render("consent_success.json", patient_id: patient_id, action: :ask_consent)
    end
  end

  def grant_consent(conn, %{
        "patient_id" => patient_id,
        "to_entity" => to_entity,
        "to_id" => to_id,
        "target" => target
      }) do
    with :ok <- ConsentApi.grant_consent(patient_id, to_entity, to_id, target) do
      conn
      |> put_status(:ok)
      |> render("consent_success.json", patient_id: patient_id, action: :grant_consent)
    end
  end

  def revoke_consent(conn, %{
        "patient_id" => patient_id,
        "from_entity" => from_entity,
        "from_id" => from_id,
        "target" => target
      }) do
    with :ok <- ConsentApi.revoke_consent(patient_id, from_entity, from_id, target) do
      conn
      |> put_status(:ok)
      |> render("consent_success.json", patient_id: patient_id, action: :revoke_consent)
    end
  end

  def list_consents(conn, %{"patient_id" => patient_id}) do
    list = ConsentApi.consents(patient_id)

    conn
    |> put_status(:ok)
    |> render("list_consent.json", list: list)
  end

  def has_consent?(
        conn,
        %{
          "patient_id" => patient_id,
          "entity_name" => entity_name,
          "entity_id" => entity_id
        } = params
      ) do
    has_consent =
      ConsentApi.has_consent?(patient_id, entity_name, entity_id, params["permission"] || :all)

    conn
    |> put_status(:ok)
    |> render("has_consent.json", has_consent: has_consent)
  end
end
