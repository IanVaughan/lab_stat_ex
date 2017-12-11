defmodule Workers.Branch do
  alias LabStatEx.{Repo, User, Branch}
  require Ecto.Query
  import Logger, only: [info: 1]

  # @delete_after_notified 30

  def perform(branch_id) do
    info "#{__MODULE__} perform:#{branch_id}"
    Repo.get(Branch, branch_id, preload: :user)
    |> process
  end

  defp process(nil), do: nil
  defp process(branch) do
    user_email = branch.commit["author_email"]
    # if user_email do
    #   User
    #   |> Repo.get_by(email: user_email)
    #   |> create_user(branch.commit)
    #   |> update_branch(branch)
    #
    #   info "#{__MODULE__} user:#{user_email}"
    #   if branch.notified_old_at == nil do
    #   else
    #     # info "#{__MODULE__} user:"
    #     # if branch.notified_old_at < @delete_after_notified.ago do
    #     #   delete(branch)
    #     # end
    #   end
    # end
  end

  defp update_branch(user, branch) do
    branch = Repo.preload branch, :user
    branch = Ecto.Changeset.change branch, user: user
    Repo.update branch
  end

  defp create_user(nil, commit) do
    # Give unknown users a high id
    count = Repo.aggregate(User, :count, :id)
    %User{id: count + 10000, email: commit["author_email"], name: commit["author_name"]}
    |> Repo.insert!
  end
  defp create_user(_user, _commit), do: nil

  defp delete(branch) do
    info "Workers::Branch deleting branch project_id:#{branch.project.id} (#{branch.project.name}), branch:#{branch.name}, reason:#{branch.delete_reason}"
    # Gitlab.delete_branch(branch.project.id, branch.name)
    # branch.destroy || deleted_at = now
    branch.destroy
  end
end
