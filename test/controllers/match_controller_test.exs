defmodule Talentgrid.MatchControllerTest do
  use Talentgrid.ConnCase

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, match_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing matches"
  end

end
