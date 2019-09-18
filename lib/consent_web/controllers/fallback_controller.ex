defmodule ConsentWeb.FallbackController do
  use ConsentWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ConsentWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :validation_error, error}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ConsentWeb.ErrorView)
    |> assign(:error, :validation_error)
    |> assign(:message, error)
    |> render(:"422")
  end

  def call(conn, {:error, :consent_already_granted}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ConsentWeb.ErrorView)
    |> assign(:error, :consent_already_granted)
    |> render(:"422")
  end

  def call(conn, {:error, :consent_not_granted}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ConsentWeb.ErrorView)
    |> assign(:error, :consent_not_granted)
    |> render(:"422")
  end

end
