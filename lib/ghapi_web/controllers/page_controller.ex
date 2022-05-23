defmodule GhapiWeb.PageController do
  use GhapiWeb, :controller

  def index(conn, _params) do
    ids = Ghapi.Pulls.get()
    render conn, "index.html", ids: ids
  end

  def comments(conn, %{"id" => id}) do
    comments = Ghapi.Pulls.get_by_id(id)
    render conn, "comment.html", comments: comments
  end
end
