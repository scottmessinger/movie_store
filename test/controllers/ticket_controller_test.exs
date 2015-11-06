defmodule MovieStore.TicketControllerTest do
  use MovieStore.ConnCase

  alias MovieStore.Ticket
  @valid_attrs %{quantity: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, ticket_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tickets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, ticket_path(conn, :new)
    assert html_response(conn, 200) =~ "New ticket"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, ticket_path(conn, :create), ticket: @valid_attrs
    assert redirected_to(conn) == ticket_path(conn, :index)
    assert Repo.get_by(Ticket, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, ticket_path(conn, :create), ticket: @invalid_attrs
    assert html_response(conn, 200) =~ "New ticket"
  end

  test "shows chosen resource", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = get conn, ticket_path(conn, :show, ticket)
    assert html_response(conn, 200) =~ "Show ticket"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, ticket_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = get conn, ticket_path(conn, :edit, ticket)
    assert html_response(conn, 200) =~ "Edit ticket"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = put conn, ticket_path(conn, :update, ticket), ticket: @valid_attrs
    assert redirected_to(conn) == ticket_path(conn, :show, ticket)
    assert Repo.get_by(Ticket, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = put conn, ticket_path(conn, :update, ticket), ticket: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit ticket"
  end

  test "deletes chosen resource", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = delete conn, ticket_path(conn, :delete, ticket)
    assert redirected_to(conn) == ticket_path(conn, :index)
    refute Repo.get(Ticket, ticket.id)
  end
end
