defmodule BananaBankWeb.UsersControllerTest do
  alias BananaBank.Users.User
  alias BananaBank.Users
  use BananaBankWeb.ConnCase

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      params = %{
        name: "John Doe",
        cep: "12345678",
        email: "john@doe.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{"cep" => "12345678", "email" => "john@doe.com", "id" => _id, "name" => "John Doe"},
               "message" => "User created successfully"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: nil,
        cep: "12",
        email: "john@doe.com",
        password: "12"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "name" => ["can't be blank"],
          "cep" => ["should be 8 character(s)"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert expected_response == response
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn} do
      params = %{
        name: "John Doe",
        cep: "12345678",
        email: "john@doe.com",
        password: "123456"
      }

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}", params)
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"cep" => "12345678", "email" => "john@doe.com", "id" => id, "name" => "John Doe"}
      }

      assert expected_response == response
    end
  end
end
