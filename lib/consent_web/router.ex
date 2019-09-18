defmodule ConsentWeb.Router do
  use ConsentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ConsentWeb do
    pipe_through :api

    post "/patients/:patient_id/consents/ask", ConsentController, :ask_consent
    post "/patients/:patient_id/consents/grant", ConsentController, :grant_consent
    post "/patients/:patient_id/consents/revoke", ConsentController, :revoke_consent

    get "/patients/:patient_id/consents", ConsentController, :list_consents
    get "/patients/:patient_id/consents/filter", ConsentController, :has_consent?

  end
end
