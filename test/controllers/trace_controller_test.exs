defmodule Talentgrid.TraceControllerTest do
  use Talentgrid.ConnCase

  # alias Talentgrid.Trace

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, trace_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing likes"
  end

end
