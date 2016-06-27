defmodule Talentgrid.MatchControllerTest do
  use Talentgrid.ConnCase

  alias Talentgrid.Match

  @valid_attrs %{score: "120.5", source: "some content", target: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, match_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing matches"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, match_path(conn, :create), match: @valid_attrs
    assert redirected_to(conn) == match_path(conn, :index)
    %{source: source, target: target} = @valid_attrs
    assert Repo.get_by(Match, %{source: source, target: target})
  end

end
