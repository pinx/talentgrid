defmodule Mix.Tasks.Talentgrid.Seed do
  use Mix.Task
  alias Talentgrid.{Repo, User, Trace}
  import Ecto

  def run(_) do
    Mix.Task.run "app.start", []
    seed(Mix.env)
  end

  def seed(env) do
    seed_companies
    seed_users(env)
    seed_traces
  end


  defp seed_companies do
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
  end

  defp seed_traces do
    # Random traces for every user
    for u <- Repo.all(User) do
      # Add some traces in a specific range
      offset = Enum.random(1..900)
      for i <- 1..100 do
        trace = %{
          user_id: u.id,
          source: "facebook",
          subject_id: to_string(offset + Enum.random(1..100)),
          user_name: u.name,
          text: Enum.join(Faker.Lorem.words(2), " ")
        }
        changeset = Trace.changeset(%Trace{}, trace)
        Repo.insert(changeset)
      end
      # Add random traces for the whole range
      for i <- 1..100 do
        trace = %{
          user_id: u.id,
          source: "facebook",
          subject_id: to_string(Enum.random(1..1000)),
          user_name: u.name,
          text: Enum.join(Faker.Lorem.words(2), " ")
        }
        changeset = Trace.changeset(%Trace{}, trace)
        Repo.insert(changeset)
      end
    end
  end

  defp seed_users(env) do
    for u <- test_users(env)
      do
        Repo.insert(u)
    end
  end

  defp test_users(:prod) do
    [
      %User{id: 110114756069639, name: "Barbara"},
      %User{id: 104238143325365, name: "Talent"},
      %User{id: 100012112842289, name: "Jennifer"},
      %User{id: 100012057344759, name: "Joe"},
      %User{id: 100011990117480, name: "Patricia"},
      %User{id: 10154097929868686, name: "Marcel van Pinxteren"},
      %User{id: 279084319100892, name: "Edmond Tan"}
    ]
  end
  defp test_users(:dev) do
    [
      %User{id: 101037296980973, name: "Mary"},
      %User{id: 100012058126657, name: "Sharon"},
      %User{id: 100012048107346, name: "Dorothy"},
      %User{id: 100012034007661, name: "Emily"},
      %User{id: 10154097929868686, name: "Marcel van Pinxteren"}
    ]
  end
  defp test_users(_env) do
    []
  end
end

