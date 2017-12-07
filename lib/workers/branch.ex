defmodule Workers.Branch do
  alias LabStatEx.{Repo, User, Branch}
  require Ecto.Query
  import Logger, only: [info: 1]

  def perform(branch_id) do
    info "#{__MODULE__} perform:#{branch_id}"
    branch = Repo.get(Branch, branch_id)
    user_email = branch.commit["author_email"]
    user = User |> Repo.get_by(email: user_email)

    # # Give unknown users a high id
    # user ||= User.create!(email: branch.commit["author_email"], name: branch.commit["author_name"], id: User.count + 10000)
    # branch.update(user: user)

    info "#{__MODULE__} user:#{user_email}"
    if branch.notified_old_at == nil do
      info "#{__MODULE__} user nil"
    else
      info "#{__MODULE__} user:#{user}"

      # if branch.notified_old_at < DELETE_AFTER_NOTIFIED.ago do
      #   # delete_branch(branch)
      #   # branch.destroy
      # end
    end
  end
end

# def delete_branch(branch)
# logger.info "Workers::Branch deleting branch project_id:#{branch.project.id} (#{branch.project.name}), branch:#{branch.name}, reason:#{branch.delete_reason}"
# # Gitlab.delete_branch(branch.project.id, branch.name)
# end
