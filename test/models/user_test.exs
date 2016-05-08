defmodule Talentgrid.UserTest do
  use Talentgrid.ModelCase

  alias Talentgrid.User

  @valid_attrs %{id: 1234, authentication_token: "some content", current_sign_in_at: "2010-04-17 14:00:00", current_sign_in_ip: "some content", email: "some content", facebook_token: "some content", last_sign_in_at: "2010-04-17 14:00:00", last_sign_in_ip: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
