ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Karaoke.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Karaoke.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Karaoke.Repo)

