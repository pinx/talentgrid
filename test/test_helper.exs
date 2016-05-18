ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Talentgrid.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Talentgrid.Repo --quiet)
Ecto.Adapters.SQL.Sandbox.mode(Talentgrid.Repo, :manual)
