defmodule Talentgrid.PageController do
  use Talentgrid.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
