# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Talentgrid.Repo.insert!(%Talentgrid.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Talentgrid.{Repo, User, Like}

Faker.start

for i <- 1..50 do
  user = %{
    id: i,
    name: Faker.Name.name,
    email: Faker.Internet.email
  }
  u = Repo.insert!(User.changeset(%User{}, user))
end

for u <- [
  %User{id: 110114756069639, name: "Barbara"},
  %User{id: 104238143325365, name: "Talent"},
  %User{id: 100012112842289, name: "Jennifer"},
  %User{id: 100012057344759, name: "Joe"},
  %User{id: 100011990117480, name: "Patricia"},
] do
  Repo.insert(u)
end

for u <- Repo.all(User) do
  for i <- 1..100 do
    like = %{
      user_id: u.id,
      page_id: Enum.random(1..1000),
      name: Enum.join(Faker.Lorem.words(2), " ")
    }
    changeset = Like.changeset(%Like{}, like)
    Repo.insert(changeset)
  end
end
