# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Chate.Repo.insert!(%Chate.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Chate.Repo.delete_all(Chate.Coherence.User)

Chate.Coherence.User.changeset(%Chate.Coherence.User{}, %{
  name: System.get_env("DEFAULT_NAME"),
  email: System.get_env("DEFAULT_EMAIL"),
  password: System.get_env("DEFAULT_PASSWORD"),
  password_confirmation: System.get_env("DEFAULT_PASSWORD")
})
|> Chate.Repo.insert!()
|> Coherence.ControllerHelpers.confirm!()
