defmodule Talentgrid.Admin do
  import Plug.Conn
  require Logger
  alias Talentgrid.Account

  @behaviour Plug

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user = get_session(conn, :current_user)
    if user && user.role == "admin" do
      Logger.warn("admin access")
      Logger.warn(inspect conn.remote_ip)
      conn
    else
      Logger.warn("admin access denied")
      conn
      |> Phoenix.Controller.redirect(to: "/")
      |> halt()
    end
  end

end
