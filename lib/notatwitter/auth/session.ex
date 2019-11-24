defmodule Notatwitter.Auth.Session do
  @moduledoc false

  alias Notatwitter.Auth
  alias Notatwitter.Auth.UserManager

  def authenticate(username, password) do
    with {:ok, user} <- UserManager.find_by(username: username),
         :ok <- verify_pass(password, user.password_hash),
         {:ok, token, _} <- Guardian.encode_and_sign(Auth.Guardian, user) do
      {:ok, user, token}
    else
      error ->
        {:error, :invalid_credentials}
    end
  end

  defp verify_pass(password, password_hash) do
    if Argon2.verify_pass(password, password_hash) do
      :ok
    else
      :error
    end
  end
end
