defmodule MovieStore.TicketTest do
  use MovieStore.ModelCase

  alias MovieStore.Ticket

  @valid_attrs %{quantity: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @invalid_attrs)
    refute changeset.valid?
  end
end
