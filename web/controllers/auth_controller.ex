defmodule Talentgrid.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use Talentgrid.Web, :controller

  plug Ueberauth
  alias Ueberauth.Strategy.Helpers

  alias Talentgrid.User

  require Logger

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    Logger.warn(inspect auth)
    case UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        Logger.warn(inspect user)
        user = get_or_create_user(user)
        Logger.warn(inspect user)
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end



  defp get_or_create_user(user) do
    db_user = Repo.get_by(User, id: user.id)
    case db_user do
      nil -> create_user(user)
      usr -> update_user(usr, user)
    end
  end

  defp create_user(user) do
    Logger.debug(inspect user)
    changeset = User.changeset(%User{}, user)
    Repo.insert!(changeset)
  end

  defp update_user(db_user, user) do
    changeset = User.changeset(db_user, user)
    Repo.update!(changeset)
  end
end
