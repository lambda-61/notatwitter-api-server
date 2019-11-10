defmodule Mix.Tasks.Seed do
  @moduledoc false

  alias Notatwitter.Auth.UserManager

  def run(_) do
    Mix.Task.run("app.start", [])
    attrs = %{username: "test", password: "testtest"}
    {:ok, _} = UserManager.create(attrs)
  end
end
