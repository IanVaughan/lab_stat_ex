# LabStatEx

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


mix ecto.gen.migration create_schema

mix ecto.migrate
mix ecto.rollback

iex -S mix


project = %LabStatEx.Project{}
p = %{project | description: "bar", name: "F", name_with_namespace: "a", path: "b", path_with_namespace: "1"}
LabStatEx.Repo.insert(p)

LabStatEx.Project |> LabStatEx.Repo.one || all
LabStatEx.Project |> LabStatEx.Repo.get(1)
LabStatEx.Project |> LabStatEx.Repo.get_by(path: "b")
require Ecto.Query
LabStatEx.Project |> Ecto.Query.where(path: "b") |> LabStatEx.Repo.all


alias LabStatEx.{Repo, Project, Branch}

Repo.all(Project) |> Repo.preload(:branches)
