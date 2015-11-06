defmodule MovieStore.ShowingControllerTest do
  use MovieStore.ConnCase

  alias MovieStore.Showing
  @valid_attrs %{start_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, showing_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing showings"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, showing_path(conn, :new)
    assert html_response(conn, 200) =~ "New showing"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, showing_path(conn, :create), showing: @valid_attrs
    assert redirected_to(conn) == showing_path(conn, :index)
    assert Repo.get_by(Showing, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, showing_path(conn, :create), showing: @invalid_attrs
    assert html_response(conn, 200) =~ "New showing"
  end

  test "shows chosen resource", %{conn: conn} do
    showing = Repo.insert! %Showing{}
    conn = get conn, showing_path(conn, :show, showing)
    assert html_response(conn, 200) =~ "Show showing"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, showing_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    showing = Repo.insert! %Showing{}
    conn = get conn, showing_path(conn, :edit, showing)
    assert html_response(conn, 200) =~ "Edit showing"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    showing = Repo.insert! %Showing{}
    conn = put conn, showing_path(conn, :update, showing), showing: @valid_attrs
    assert redirected_to(conn) == showing_path(conn, :show, showing)
    assert Repo.get_by(Showing, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    showing = Repo.insert! %Showing{}
    conn = put conn, showing_path(conn, :update, showing), showing: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit showing"
  end

  test "deletes chosen resource", %{conn: conn} do
    showing = Repo.insert! %Showing{}
    conn = delete conn, showing_path(conn, :delete, showing)
    assert redirected_to(conn) == showing_path(conn, :index)
    refute Repo.get(Showing, showing.id)
  end
end
