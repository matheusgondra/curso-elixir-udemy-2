defmodule BananaBank.Accounts.Account do
  alias BananaBank.Users.User
  use Ecto.Schema

  import Ecto.Changeset

  @required_params ~w(balance user_id)a

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  def changeset(account \\ %__MODULE__{}, params) do
    account
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_positive)
    |> unique_constraint(:user_id, name: :accounts_user_id_unique)
  end
end
