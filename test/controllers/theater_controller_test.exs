defmodule MovieStore.TheaterControllerTest do
  use MovieStore.ConnCase

  alias MovieStore.Theater
  @valid_attrs %{capacity: 42, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, theater_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing theaters"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, theater_path(conn, :new)
    assert html_response(conn, 200) =~ "New theater"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, theater_path(conn, :create), theater: @valid_attrs
    assert redirected_to(conn) == theater_path(conn, :index)
    assert Repo.get_by(Theater, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, theater_path(conn, :create), theater: @invalid_attrs
    assert html_response(conn, 200) =~ "New theater"
  end

  test "shows chosen resource", %{conn: conn} do
    theater = Repo.insert! %Theater{}
    conn = get conn, theater_path(conn, :show, theater)
    assert html_response(conn, 200) =~ "Show theater"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, theater_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    theater = Repo.insert! %Theater{}
    conn = get conn, theater_path(conn, :edit, theater)
    assert html_response(conn, 200) =~ "Edit theater"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    theater = Repo.insert! %Theater{}
    conn = put conn, theater_path(conn, :update, theater), theater: @valid_attrs
    assert redirected_to(conn) == theater_path(conn, :show, theater)
    assert Repo.get_by(Theater, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    theater = Repo.insert! %Theater{}
    conn = put conn, theater_path(conn, :update, theater), theater: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit theater"
  end

  test "deletes chosen resource", %{conn: conn} do
    theater = Repo.insert! %Theater{}
    conn = delete conn, theater_path(conn, :delete, theater)
    assert redirected_to(conn) == theater_path(conn, :index)
    refute Repo.get(Theater, theater.id)
  end
end
