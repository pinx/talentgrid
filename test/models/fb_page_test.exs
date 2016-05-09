defmodule Talentgrid.FbPageTest do
  use Talentgrid.ModelCase

  alias Talentgrid.FbPage

  @valid_attrs %{text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FbPage.changeset(%FbPage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FbPage.changeset(%FbPage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
