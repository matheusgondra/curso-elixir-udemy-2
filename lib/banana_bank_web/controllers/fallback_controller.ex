defmodule BananaBankWeb.FallbackController do
  use BananaBankWeb, :controller

  alias BananaBankWeb.ErrorJSON

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, :not_found_login}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :error_login)
  end

  def call(conn, {:error, :unauthorized_login}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :error_login)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :bad_request)
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, msg}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, msg: msg)
  end
end
