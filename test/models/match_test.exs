defmodule Talentgrid.MatchTest do
  use Talentgrid.ModelCase

  alias Talentgrid.Match

  @valid_attrs %{score: "120.5", source: "some content", target: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Match.changeset(%Match{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Match.changeset(%Match{}, @invalid_attrs)
    refute changeset.valid?
  end
end
