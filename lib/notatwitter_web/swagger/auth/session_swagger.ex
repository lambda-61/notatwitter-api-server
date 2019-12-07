defmodule NotatwitterWeb.Auth.SessionSwagger do
  @moduledoc false

  alias PhoenixSwagger.Path
  alias PhoenixSwagger.Path.PathObject
  alias PhoenixSwagger.Schema

  # ===== Parameters =====

  def login_parameters(%PathObject{} = path) do
    path
    |> Path.parameter(:username, :body, :string, "", required: true)
    |> Path.parameter(:password, :body, :string, "", required: true)
  end

  # ===== Schemas =====

  def login_schema do
    %Schema{type: :object}
    |> Schema.property(:id, :integer, "", required: true)
    |> Schema.property(:username, :string, "", required: true)
    |> Schema.property(
      :token,
      :string,
      "JWT token; you do not need to use it as you are authorized by cookies",
      required: true
    )
  end

  def session_schema do
    %Schema{type: :object}
    |> Schema.property(:id, :integer, "", required: true)
    |> Schema.property(:username, :string, "", required: true)
  end
end
