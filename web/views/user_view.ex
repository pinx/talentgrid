defmodule Talentgrid.UserView do
  use Talentgrid.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Talentgrid.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Talentgrid.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name,
      authentication_token: user.authentication_token,
      facebook_token: user.facebook_token,
      current_sign_in_at: user.current_sign_in_at,
      last_sign_in_at: user.last_sign_in_at,
      current_sign_in_ip: user.current_sign_in_ip,
      last_sign_in_ip: user.last_sign_in_ip}
  end
end
