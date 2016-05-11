defmodule Talentgrid.ProfileController do
  use Talentgrid.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", current_user: get_session(conn, :current_user)
  end

  def delete(conn, _params) do
    user = get_session(conn, :current_user)
    if user.roles != "admin" do
      Repo.delete!(user)
      conn
      |> put_flash(:info, "User deleted successfully.")
      |> configure_session(drop: true)
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:info, "Admin user can not be deleted")
      |> redirect(to: profile_path(conn, :index))
    end
  end
end

