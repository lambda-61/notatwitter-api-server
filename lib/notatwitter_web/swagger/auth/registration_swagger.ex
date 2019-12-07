defmodule NotatwitterWeb.Auth.RegistrationSwagger do
  @moduledoc false

  alias PhoenixSwagger.Path
  alias PhoenixSwagger.Path.PathObject
  alias PhoenixSwagger.Schema

  # ===== Parameters =====

  def register_parameters(%PathObject{} = path) do
    path
    |> Path.parameter(:username, :body, :string, "", required: true)
    |> Path.parameter(:password, :body, :string, "", required: true)
  end

  # ===== Schemas =====

  def register_schema do
    %Schema{type: :object}
    |> Schema.property(:id, :integer, "", required: true)
    |> Schema.property(:username, :string, "", required: true)
  end
end
