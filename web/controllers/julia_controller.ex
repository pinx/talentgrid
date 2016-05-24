defmodule Talentgrid.JuliaController do
  use Talentgrid.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"julia" => %{"script" => script}}) do
    args = ["-e", script]
    #TODO: capture Julia errors; now they go to stderr
    %{err: error, out: result} = Porcelain.exec("julia", args)
    render(conn, "new.html", result: result, error: error)
  end
end
