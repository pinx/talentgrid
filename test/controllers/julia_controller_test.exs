defmodule Talentgrid.JuliaControllerTest do
  use Talentgrid.ConnCase

  @test_script "println(2+2)"

  test "show test area on index", %{conn: conn} do
    conn = get conn, julia_path(conn, :index)
    assert html_response(conn, 200) =~ ~r{textarea.+julia_script}
  end

  test "runs Julia calculation", %{conn: conn} do
    conn = post conn, julia_path(conn, :create), julia: %{script: @test_script}
    assert html_response(conn, 200) =~ ~r{Result:\n4}
  end
end
