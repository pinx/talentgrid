defmodule Talentgrid.LikeTest do
  use Talentgrid.ModelCase

  alias Talentgrid.Like

  @valid_attrs %{user_id: "some content", page_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Like.changeset(%Like{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Like.changeset(%Like{}, @invalid_attrs)
    refute changeset.valid?
  end
end
