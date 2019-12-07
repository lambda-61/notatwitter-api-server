defmodule NotatwitterWeb.UserSwagger do
  @moduledoc false

  alias NotatwitterWeb.CommonSwagger
  alias PhoenixSwagger.Path
  alias PhoenixSwagger.Path.PathObject
  alias PhoenixSwagger.Schema

  # ===== Parameters =====

  def update_parameters(%PathObject{} = path) do
    path
    |> CommonSwagger.id_parameter()
    |> Path.parameter(:username, :body, :string, "")
    |> Path.parameter(
      :avatar,
      :body,
      :multipart,
      "multipart/form-data parameter"
    )
  end

  # ===== Schemas =====

  def index_schema do
    Schema.items(%Schema{type: :array}, show_schema())
  end

  def show_schema do
    %Schema{type: :object}
    |> Schema.property(:id, :integer, "", required: true)
    |> Schema.property(:username, :string, "", required: true)
    |> Schema.property(:avatar, CommonSwagger.avatar_schema(), "",
      required: false
    )
  end
end
