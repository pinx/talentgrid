defmodule Talentgrid.ProfileControllerTest do
  use Talentgrid.ConnCase

  #TODO: need to find a way to set the session user

  test "GET /", %{conn: conn} do
    conn = get conn, "/profile"
    assert html_response(conn, 200) =~ "My Profile"
  end
end
