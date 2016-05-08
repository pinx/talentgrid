defmodule Talentgrid.LikeControllerTest do
  use Talentgrid.ConnCase

  alias Talentgrid.Like
  @valid_attrs %{user_id: "some content", page_id: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "refresh likes in database", %{conn: conn} do
    conn = get conn, like_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

end
