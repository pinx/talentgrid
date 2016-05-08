defmodule Talentgrid.LikeView do
  use Talentgrid.Web, :view

  def render("index.json", %{likes: likes}) do
    %{data: render_many(likes, Talentgrid.LikeView, "like.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, Talentgrid.LikeView, "like.json")}
  end

  def render("like.json", %{like: like}) do
    %{id: like.id,
      user_id: like.user_id,
      page_id: like.page_id,
      name: like.name,
      created_time: like.created_time
    }
  end
end
