# LabStatEx

Get stats about your GitLab, including :

* Branches
  * Notify committer of old branches
  * Delete old branches on GitLab
* TODO
* Push counts of
  * Projects
  * Branches
  * Jobs
  * etc
* Add comments to old MRs

## Development

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

* `mix ecto.gen.migration create_schema`
* `mix ecto.migrate`
* `mix ecto.rollback`
* `iex -S mix`
* http://localhost:4040/


{:ok, jid} = Exq.enqueue(Exq, "default",  Workers.Projects, [])
