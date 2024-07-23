defmodule BananaBankWeb.UsersJSON do
  def create(%{user: user}) do
    %{
      message: "User created successfully",
      id: user.id,
      name: user.name,
      cep: user.cep,
      email: user.email
    }
  end
end
