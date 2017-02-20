defmodule Insight.SessionControllerTest do
  use Insight.ConnCase

  alias Insight.{Session, Repo}

  @valid_attrs %{email: "fizz@buzz.com", password: "password"}

  setup %{conn: conn} do
    insert_user @valid_attrs
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: @valid_attrs
    token = json_response(conn, 201)["data"]["token"]
    assert token
    assert Repo.get_by(Session, token: token)
  end

  test "does not create resource and renders errors when password is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :password, "notright")
    assert json_response(conn, 401)["errors"] != %{}
  end

  test "does not create resource and renders errors when email is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :email, "not#found.com")
    assert json_response(conn, 401)["errors"] != %{}
  end

end
