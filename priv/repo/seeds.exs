# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Insight.Repo.insert!(%Insight.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Insight.Repo
alias Insight.User

Repo.delete_all User

Repo.insert! %User{
  name: "Draven",
  email: "i@draveness.me",
  password_hash: "password"
}
