defmodule BananaBankWeb.FallbackController do
  use BananaBankWeb, :controller

  alias BananaBankWeb.ErrorJSON

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
