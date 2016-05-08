defmodule Talentgrid.SessionController do
  use Talentgrid.Web, :controller

  alias Talentgrid.User

  # plug :scrub_params, "user" when action in [:create]

  def create(conn, params = %{}) do
    %{"email" => email, "facebook_token" => facebook_token} = params
    user = get_or_create_user(%User{email: email, facebook_token: facebook_token})
    conn
    |> put_status(:created)
    |> fetch_session
    |> put_session(:user, user)
    |> render("show.json", user: user)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  # def delete(conn, _params) do

  #   send_resp(conn, :no_content, "")
  # end

  # defp sign_out(conn) do
  #   conn.session
  # end

  defp get_or_create_user(user) do
    case Repo.get_by(User, email: user.email) do
      nil -> create_user(user)
      usr -> usr
    end
  end

  defp create_user(user) do
    Repo.insert!(user)
  end
end
