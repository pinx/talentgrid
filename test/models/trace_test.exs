defmodule Talentgrid.TraceTest do
  use Talentgrid.ModelCase

  alias Talentgrid.Trace

  @valid_attrs %{user_id: 1234, source: "reddit", subject_id: "12345"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Trace.changeset(%Trace{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Trace.changeset(%Trace{}, @invalid_attrs)
    refute changeset.valid?
  end
end
