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

# Companies
for u <- [
  %User{id: 1, name: "Microsoft", avatar: "https://cdn2.iconfinder.com/data/icons/metro-ui-dock/128/Microsoft.png", roles: "employer"},
  %User{id: 2, name: "Oracle", avatar: "https://cdn4.iconfinder.com/data/icons/flat-brand-logo-2/512/oracle-128.png", roles: "employer"},
  %User{id: 3, name: "SAP", avatar: "https://cdn4.iconfinder.com/data/icons/business-services-vol-1/26/37_sap_sign_logo_software_solution_technology_security_integration-128.png", roles: "employer"},
  %User{id: 4, name: "Salesforce", avatar: "https://cdn4.iconfinder.com/data/icons/business-services-vol-1/26/39_salesforce_server_cloud_computing_company_business-128.png", roles: "employer"},
  %User{id: 5, name: "Symantec", avatar: "https://cdn2.iconfinder.com/data/icons/orbiconspack/PNG/Symantec.png", roles: "employer"},
  %User{id: 6, name: "VMWare", avatar: "https://cdn2.iconfinder.com/data/icons/system-flat-buttons/512/vmware-128.png", roles: "employer"},
  %User{id: 7, name: "Facebook", avatar: "https://cdn1.iconfinder.com/data/icons/logotypes/32/square-facebook-128.png", roles: "employer"},
  %User{id: 8, name: "Twitter", avatar: "https://cdn1.iconfinder.com/data/icons/logotypes/32/square-twitter-128.png", roles: "employer"},
  %User{id: 9, name: "Google", avatar: "https://cdn4.iconfinder.com/data/icons/new-google-logo-2015/400/new-google-favicon-128.png", roles: "employer"},
] do
  Repo.insert(u)
end

# Random users
# for i <- 11..50 do
#   user = %{
#     id: i,
#     name: Faker.Name.name,
#     email: Faker.Internet.email
#   }
#   u = Repo.insert!(User.changeset(%User{}, user))
# end

# Registered test users
for u <- [
  %User{id: 110114756069639, name: "Barbara"},
  %User{id: 104238143325365, name: "Talent"},
  %User{id: 100012112842289, name: "Jennifer"},
  %User{id: 100012057344759, name: "Joe"},
  %User{id: 100011990117480, name: "Patricia"}
] do
  Repo.insert(u)
end

# Random likes for every user
for u <- Repo.all(User) do
  # Add some likes in a specific range
  offset = Enum.random(1..900)
  for i <- 1..100 do
    like = %{
      user_id: u.id,
      page_id: offset + Enum.random(1..100),
      name: Enum.join(Faker.Lorem.words(2), " ")
    }
    changeset = Like.changeset(%Like{}, like)
    Repo.insert(changeset)
  end
  # Add random likes for the whole range
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
