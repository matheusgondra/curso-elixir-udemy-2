defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import Mox

  alias BananaBank.Users.User
  alias BananaBank.Users
  alias BananaBank.ViaCep.ClientMock

  setup :verify_on_exit!

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      params = %{
        "name" => "John Doe",
        "cep" => "29560000",
        "email" => "john@doe.com",
        "password" => "123456"
      }

      body = %{
        "bairro" => "",
        "cep" => "29560-000",
        "complemento" => "",
        "ddd" => "28",
        "gia" => "",
        "ibge" => "3202306",
        "localidade" => "Guaiçu",
        "siafi" => "5645",
        "uf" => "ES"
      }

      expect(ClientMock, :call, fn "29560000" ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{"cep" => "29560000", "email" => "john@doe.com", "id" => _id, "name" => "John Doe"},
               "message" => "User created successfully"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        "name" => nil,
        "cep" => "29560000",
        "email" => "john@doe.com",
        "password" => "12"
      }

      body = %{
        "bairro" => "",
        "cep" => "29560-000",
        "complemento" => "",
        "ddd" => "28",
        "gia" => "",
        "ibge" => "3202306",
        "localidade" => "Guaiçu",
        "siafi" => "5645",
        "uf" => "ES"
      }

      expect(ClientMock, :call, fn "29560000" ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "name" => ["can't be blank"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert expected_response == response
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn} do
      params = %{
        "name" => "John Doe",
        "cep" => "29560000",
        "email" => "john@doe.com",
        "password" => "123456"
      }

      body = %{
        "bairro" => "",
        "cep" => "29560-000",
        "complemento" => "",
        "ddd" => "28",
        "gia" => "",
        "ibge" => "3202306",
        "localidade" => "Guaiçu",
        "siafi" => "5645",
        "uf" => "ES"
      }

      expect(ClientMock, :call, fn "29560000" ->
        {:ok, body}
      end)

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}", params)
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"cep" => "29560000", "email" => "john@doe.com", "id" => id, "name" => "John Doe"}
      }

      assert expected_response == response
    end
  end
end
