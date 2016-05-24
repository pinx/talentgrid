defmodule Talentgrid.UserControllerTest do
  use Talentgrid.ConnCase

  use Plug.Test

  alias Talentgrid.User
  require Logger

  @initial_attrs %{id: 1234, name: "initial name"}
  @valid_attrs %{id: 1234, name: "some name", facebook_token: "<fb-token>"}
  @invalid_attrs %{id: 1234, name: nil}

  @default_opts [
    store: :cookie,
    key: "talentgrid",
    signing_salt: "signing salt",
    log: false
  ]
  @signing_opts Plug.Session.init(@default_opts)

  setup %{conn: conn} do
    Ecto.Adapters.SQL.Sandbox.checkout(Talentgrid.Repo)
    user = Repo.insert!(%User{id: 1, name: "admin", roles: "admin", facebook_token: "<admin-token>"})
    conn = conn
      |> Plug.Session.call(@signing_opts)
      |> fetch_session()
      |> put_session(:current_user, user)
    {:ok, conn: conn}
  end

  test "requires user authentication on all actions", %{conn: conn} do
    conn = put_session(conn, :current_user, nil)
    Enum.each([
      get(conn, user_path(conn, :new)),
      get(conn, user_path(conn, :index)),
      get(conn, user_path(conn, :show, "123")),
      get(conn, user_path(conn, :edit, "123")),
      put(conn, user_path(conn, :update, "123", %{})),
      post(conn, user_path(conn, :create, %{})),
      delete(conn, user_path(conn, :delete, "123")),
    ], fn conn ->
    assert html_response(conn, 302)
    assert conn.halted
    end)
  end

  # TODO: session is not set correctly, so all tests fail

  # test "lists all entries on index", %{conn: conn} do
  #   conn = set_user(conn)
  #   Logger.warn("=======================")
  #   Logger.warn(inspect get_session(conn, :current_user))
  #   conn = get conn, user_path(conn, :index)
  #   assert html_response(conn, 200) =~ "Listing users"
  # end

  # test "renders form for new resources", %{conn: conn} do
  #   conn = get conn, user_path(conn, :new)
  #   assert html_response(conn, 200) =~ "New user"
  # end

  # test "creates resource and redirects when data is valid", %{conn: conn} do
  #   conn = post conn, user_path(conn, :create), user: @valid_attrs
  #   assert redirected_to(conn) == user_path(conn, :index)
  #   assert Repo.get_by(User, @valid_attrs)
  # end

  # test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  #   conn = post conn, user_path(conn, :create), user: @invalid_attrs
  #   assert html_response(conn, 200) =~ "New user"
  # end

  # test "shows chosen resource", %{conn: conn} do
  #   user = Repo.insert!(User.changeset(%User{}, @initial_attrs))
  #   conn = get conn, user_path(conn, :show, user)
  #   assert html_response(conn, 200) =~ "Show user"
  # end

  # test "renders page not found when id is nonexistent", %{conn: conn} do
  #   assert_error_sent 404, fn ->
  #     get conn, user_path(conn, :show, -1)
  #   end
  # end

  # test "renders form for editing chosen resource", %{conn: conn} do
  #   user = Repo.insert!(User.changeset(%User{}, @initial_attrs))
  #   conn = get conn, user_path(conn, :edit, user)
  #   assert html_response(conn, 200) =~ "Edit user"
  # end

  # test "updates chosen resource and redirects when data is valid", %{conn: conn} do
  #   user = Repo.insert!(User.changeset(%User{}, @initial_attrs))
  #   conn = put conn, user_path(conn, :update, user), user: @valid_attrs
  #   assert redirected_to(conn) == user_path(conn, :show, user)
  #   assert Repo.get_by(User, @valid_attrs)
  # end

  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   user = Repo.insert!(User.changeset(%User{}, @initial_attrs))
  #   conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
  #   assert html_response(conn, 200) =~ "Edit user"
  # end

  # test "deletes chosen resource", %{conn: conn} do
  #   user = Repo.insert!(User.changeset(%User{}, @initial_attrs))
  #   conn = delete conn, user_path(conn, :delete, user)
  #   assert redirected_to(conn) == user_path(conn, :index)
  #   refute Repo.get(User, user.id)
  # end

  def set_user(conn) do
    user = Repo.get!(User, 1)
    Logger.warn(inspect user)
    conn
    |> Plug.Session.call(@signing_opts)
    |> fetch_session()
    |> put_session(:current_user, user)

  end

end
