defmodule MovieStore.PageController do
  use MovieStore.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
