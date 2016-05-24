defmodule Talentgrid.ImportControllerTest do
  use Talentgrid.ConnCase

  alias Talentgrid.Trace

  @valid_attrs %{}
  @invalid_attrs %{}

  test "show index", %{conn: conn} do
    conn = get conn, import_path(conn, :index)
    assert html_response(conn, 200) =~ "import_file"
  end

  test "import csv and redirects when data is valid", %{conn: conn} do
    import_file = %Plug.Upload{filename: "traces.csv", path: "test/traces.csv", content_type: "text/csv"}
    conn = post conn, import_path(conn, :create), import_file: import_file
    assert Repo.get_by(Trace, %{subject_id: "test"})
    assert redirected_to(conn) == import_path(conn, :index)
  end

  test "import json and redirects when data is valid", %{conn: conn} do
    import_file = %Plug.Upload{filename: "traces.json", path: "test/traces.json", content_type: "text/json"}
    conn = post conn, import_path(conn, :create), import_file: import_file
    assert Repo.get_by(Trace, %{subject_id: "test"})
    assert redirected_to(conn) == import_path(conn, :index)
  end

  test "does not import and renders errors when data is invalid", %{conn: conn} do
    import_file = %Plug.Upload{filename: "traces.csv", path: "test/invalid_traces.csv", content_type: "text/csv"}
    conn = post conn, import_path(conn, :create), import_file: import_file
    assert Repo.all(Trace) == []
    assert redirected_to(conn) == import_path(conn, :index)
  end
end
