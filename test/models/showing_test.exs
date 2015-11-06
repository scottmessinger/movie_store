defmodule MovieStore.ShowingTest do
  use MovieStore.ModelCase

  alias MovieStore.Showing

  @valid_attrs %{start_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Showing.changeset(%Showing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Showing.changeset(%Showing{}, @invalid_attrs)
    refute changeset.valid?
  end
end
