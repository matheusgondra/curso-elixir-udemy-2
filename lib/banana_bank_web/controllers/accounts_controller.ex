defmodule BananaBankWeb.AccountsController do
  use BananaBankWeb, :controller

  alias BananaBankWeb.FallbackController
  alias BananaBank.Accounts.Account
  alias BananaBank.Accounts

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end
end
