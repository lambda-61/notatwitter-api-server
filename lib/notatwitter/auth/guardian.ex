defmodule Notatwitter.Auth.Guardian do
  @moduledoc false

  use Guardian, otp_app: :notatwitter

  alias Notatwitter.Auth.{User, UserManager}

  def subject_for_token(%User{id: user_id}, _claims) do
    {:ok, to_string(user_id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case UserManager.find(id) do
      {:error, :not_found} -> {:error, :resource_not_found}
      {:ok, user} -> {:ok, user}
    end
  end
end
