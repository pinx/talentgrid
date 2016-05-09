defmodule Talentgrid.FbPageControllerTest do
  use Talentgrid.ConnCase

  alias Talentgrid.FbPage
  @valid_attrs %{text: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, fb_page_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing fb pages"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, fb_page_path(conn, :new)
    assert html_response(conn, 200) =~ "New fb page"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, fb_page_path(conn, :create), fb_page: @valid_attrs
    assert redirected_to(conn) == fb_page_path(conn, :index)
    assert Repo.get_by(FbPage, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, fb_page_path(conn, :create), fb_page: @invalid_attrs
    assert html_response(conn, 200) =~ "New fb page"
  end

  test "shows chosen resource", %{conn: conn} do
    fb_page = Repo.insert! %FbPage{}
    conn = get conn, fb_page_path(conn, :show, fb_page)
    assert html_response(conn, 200) =~ "Show fb page"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, fb_page_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    fb_page = Repo.insert! %FbPage{}
    conn = get conn, fb_page_path(conn, :edit, fb_page)
    assert html_response(conn, 200) =~ "Edit fb page"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    fb_page = Repo.insert! %FbPage{}
    conn = put conn, fb_page_path(conn, :update, fb_page), fb_page: @valid_attrs
    assert redirected_to(conn) == fb_page_path(conn, :show, fb_page)
    assert Repo.get_by(FbPage, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    fb_page = Repo.insert! %FbPage{}
    conn = put conn, fb_page_path(conn, :update, fb_page), fb_page: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit fb page"
  end

  test "deletes chosen resource", %{conn: conn} do
    fb_page = Repo.insert! %FbPage{}
    conn = delete conn, fb_page_path(conn, :delete, fb_page)
    assert redirected_to(conn) == fb_page_path(conn, :index)
    refute Repo.get(FbPage, fb_page.id)
  end
end
