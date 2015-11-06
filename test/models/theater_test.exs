defmodule MovieStore.TheaterTest do
  use MovieStore.ModelCase

  alias MovieStore.Theater

  @valid_attrs %{capacity: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Theater.changeset(%Theater{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Theater.changeset(%Theater{}, @invalid_attrs)
    refute changeset.valid?
  end
end
