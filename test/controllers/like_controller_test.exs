defmodule Talentgrid.LikeControllerTest do
  use Talentgrid.ConnCase

  alias Talentgrid.Like
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, like_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing likes"
  end

end
