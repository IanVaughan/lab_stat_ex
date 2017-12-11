defmodule Workers.BranchTest do
  use ExUnit.Case, async: true
  alias Workers.Branch, as: Subject
  alias LabStatEx.{Repo, Branch, Project, User}
  # require Ecto.Query

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(LabStatEx.Repo)

    project = %Project{id: 20, name: "project name", name_with_namespace: "foo/bar", path: "foo", path_with_namespace: "a"}
    Repo.insert!(project)

    :ok
  end

  describe "when branch not found" do
    test "returns" do
      assert Subject.perform(1) == nil
    end
  end

  describe "when no commit list" do
    setup do
      branch = %Branch{id: 20, project_id: 20, name: "branch_name"}
      Repo.insert!(branch)
      :ok
    end

    test "returns" do
      assert Subject.perform(20) == nil
    end
  end

  describe "when user not found" do
    setup do
      commit = %{author_email: "ian@foo.com", author_name: "Ian"}
      branch = %Branch{id: 20, project_id: 20, name: "branch_name", commit: commit}
      Repo.insert!(branch)
      {:ok, commit: commit}
    end

    test "it creates a new one with a high id", state do
      Subject.perform(20)
      user = User |> Repo.get_by(email: state[:commit].author_email)
      assert user.email == state[:commit].author_email
    end
  end

  describe "updating branch user" do
    setup do
      commit = %{author_email: "ian@foo.com", author_name: "Ian"}
      branch = %Branch{id: 20, project_id: 20, name: "branch_name", commit: commit}
      Repo.insert!(branch)
      {:ok, branch: branch}
    end

    test "updates the branch user to the commit author" do
      Subject.perform(20)
      branch = Branch |> Repo.get_by(id: 20) |> Repo.preload(:user)
      assert branch.user.email == "ian@foo.com"
    end
  end

  # describe "deleting old branches" do
  #   setup do
  #     commit = %{author_email: "ian@foo.com", author_name: "Ian"}
  #     branch = %Branch{id: 20, project_id: 20, name: "branch_name", commit: commit, notified_old_at: }
  #     Repo.insert!(branch)
  #     {:ok, branch: branch}
  #   end
  #
  #   test "it deletes branches that have been notified_old_at" do
  #     Subject.perform(20)
  #     branch = Branch |> Repo.get_by(id: 20) |> Repo.preload(:user)
  #     assert branch.user.email == "ian@foo.com"
  #   end
  # end
end
