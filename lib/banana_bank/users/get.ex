defmodule BananaBank.Users.Get do
  alias BananaBank.Repo
  alias BananaBank.Users.User

  def call(email) when is_bitstring(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

end
