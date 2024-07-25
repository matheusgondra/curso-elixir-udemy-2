defmodule BananaBankWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias BananaBankWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      assign(conn, :user_id, data.user_id)
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> put_view(BananaBankWeb.ErrorJSON)
        |> render(:error, status: :unauthorized)
        |> halt()
    end
  end
end
