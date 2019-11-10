defmodule Notatwitter.Repo do
  use Ecto.Repo,
    otp_app: :notatwitter,
    adapter: Ecto.Adapters.Postgres

  def find(queryable, id) do
    case get(queryable, id) do
      %_{} = schema -> {:ok, schema}
      nil -> {:error, :not_found}
    end
  end

  def find_by(queryable, opts) do
    case get_by(queryable, opts) do
      %_{} = schema -> {:ok, schema}
      nil -> {:error, :not_found}
    end
  end
end
