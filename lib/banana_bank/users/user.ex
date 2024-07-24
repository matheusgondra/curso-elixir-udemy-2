defmodule BananaBank.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @required_params [:name, :password, :email, :cep]
  @required_params_update ~w(name email cep)a

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> do_validations(@required_params)
    |> unique_constraint(:email, name: :unique_email, message: "email already exists")
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params)
    |> do_validations(@required_params_update)
    |> unique_constraint(:email, name: :unique_email)
    |> add_password_hash()
  end

  defp do_validations(changeset, fields) do
    changeset
    |> validate_required(fields)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, %{password_hash: Pbkdf2.hash_pwd_salt(password)})
  end

  defp add_password_hash(changeset), do: changeset
end
