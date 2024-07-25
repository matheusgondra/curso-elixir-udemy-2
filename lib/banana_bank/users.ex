defmodule BananaBank.Users do
  alias BananaBank.Verify
  alias BananaBank.Users.Delete
  alias BananaBank.Users.Update
  alias BananaBank.Users.Get
  alias BananaBank.Users.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id_or_email), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate login(params), to: Verify, as: :call
end
