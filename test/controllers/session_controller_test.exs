defmodule Talentgrid.SessionControllerTest do
  use Talentgrid.ConnCase

  require Logger

  alias Talentgrid.User
  @valid_attrs %{authentication_token: "some content",
    email: "test@test.com",
    facebook_token: "<a-facebook-token>"}
  @invalid_attrs %{}

  @session_opts [
    store: :cookie,
    key: "foobar",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt",
    log: false
  ]


  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates session for new user", %{conn: conn} do
    conn =
      conn
      |> Plug.Session.call(Plug.Session.init(@session_opts))
      |> fetch_session
      |> clear_session
      |> post(session_path(conn, :create), @valid_attrs)
    assert json_response(conn, 201)["data"]["id"]
    %{"data" => %{"id" => id}} = json_response(conn, 201)
    assert Repo.get!(User, id)
    assert get_session(conn, :user)
  end

  # test "deletes session", %{conn: conn} do
  #   conn = conn
  #     |> Plug.Session.call(Plug.Session.init(@session_opts))
  #     |> fetch_session
  #   conn = put_session(conn, :user, @valid_attrs)
  #     |> delete(session_path(conn, :delete, %User{id: 0}))
  #   assert response(conn, 204)
  #   refute get_session(conn, :user)
  # end
end
