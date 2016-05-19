defmodule Talentgrid.ImportControllerTest do
  use Talentgrid.ConnCase

  alias Talentgrid.Comment

  @valid_attrs %{}
  @invalid_attrs %{}

  test "show index", %{conn: conn} do
    conn = get conn, import_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing imports"
  end

  test "imports and redirects when data is valid", %{conn: conn} do
    import_file = %Plug.Upload{filename: "comments.csv", path: "test/comments.csv", content_type: "text/csv"}
    conn = post conn, import_path(conn, :create), import_file: import_file
    assert Repo.get_by(Comment, %{subject_id: "test"})
    assert redirected_to(conn) == import_path(conn, :index)
  end

  test "does not import and renders errors when data is invalid", %{conn: conn} do
    import_file = %Plug.Upload{filename: "comments.csv", path: "test/invalid_comments.csv", content_type: "text/csv"}
    conn = post conn, import_path(conn, :create), import_file: import_file
    assert Repo.all(Comment) == []
    assert redirected_to(conn) == import_path(conn, :index)
  end
end
