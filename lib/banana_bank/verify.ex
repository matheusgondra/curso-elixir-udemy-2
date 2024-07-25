defmodule BananaBank.Verify do
  alias BananaBank.Users

  def call(%{"email" => email, "password" => password}) do
    case Users.get(email) do
      {:ok, user} -> verify(user, password)
      {:error, _} = error -> error
    end
  end

  defp verify(user, password) do
    case Pbkdf2.verify_pass(password, user.password_hash) do
      true -> {:ok, :valid_password}
      false -> {:error, :unauthorized}
    end
  end
end
