defmodule BananaBank.Verify do
  alias BananaBank.Users

  def call(%{"email" => email, "password" => password}) do
    case Users.get(email) do
      {:ok, user} -> verify(user, password)
      {:error, :not_found} -> {:error, :not_found_login}
    end
  end

  defp verify(user, password) do
    case Pbkdf2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized_login}
    end
  end
end
