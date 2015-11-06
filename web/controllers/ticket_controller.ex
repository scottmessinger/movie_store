defmodule MovieStore.TicketController do
  use MovieStore.Web, :controller

  alias MovieStore.Ticket

  plug :scrub_params, "ticket" when action in [:create, :update]

  def index(conn, _params) do
    tickets = Repo.all(Ticket) |> load_ticket
    render(conn, "index.html", tickets: tickets)
  end

  def new(conn, _params) do
    changeset = Ticket.changeset(%Ticket{})
    render(conn, "new.html", changeset: changeset, showings: showings)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    changeset = Ticket.changeset(%Ticket{}, ticket_params)

    case Repo.insert(changeset) do
      {:ok, _ticket} ->
        conn
        |> put_flash(:info, "Ticket created successfully.")
        |> redirect(to: ticket_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id) |> load_ticket
    render(conn, "show.html", ticket: ticket)
  end

  def edit(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id) |> load_ticket
    changeset = Ticket.changeset(ticket)
    render(conn, "edit.html", ticket: ticket, changeset: changeset, showings: showings)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = Repo.get!(Ticket, id) |> load_ticket
    changeset = Ticket.changeset(ticket, ticket_params)

    case Repo.update(changeset) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket updated successfully.")
        |> redirect(to: ticket_path(conn, :show, ticket))
      {:error, changeset} ->
        render(conn, "edit.html", ticket: ticket, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(ticket)

    conn
    |> put_flash(:info, "Ticket deleted successfully.")
    |> redirect(to: ticket_path(conn, :index))
  end

  defp load_ticket(ticket) when is_list(ticket) do
    ticket
    |> Repo.preload(:showing)
    |> Enum.map( fn ticket ->
      showing = ticket.showing
      |> IO.inspect
      |> Repo.preload(:theater)
      |> Repo.preload(:movie)
      Map.put(ticket, :showing, showing)
    end)
  end

  defp load_ticket(ticket) do
    load_ticket([ticket]) |> Enum.at(0)
  end

  defp showings() do
    Repo.all(MovieStore.Showing)
    |> Repo.preload(:theater)
    |> Repo.preload(:movie)
    |> Enum.map( fn showing ->
      start_time = Ecto.DateTime.to_time(showing.start_at) |> Ecto.Time.to_string
      IO.inspect(showing)
      {showing.movie.name <> " at " <> showing.theater.name <> " (" <> start_time <> ")", showing.id}
    end)
  end
end
