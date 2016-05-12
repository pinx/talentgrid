defmodule Talentgrid.ProfileControllerTest do
  use Talentgrid.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "My Profile"
  end
end
