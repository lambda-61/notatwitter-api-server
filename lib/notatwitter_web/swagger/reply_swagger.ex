defmodule NotatwitterWeb.ReplySwagger do
  @moduledoc false

  alias NotatwitterWeb.CommonSwagger
  alias PhoenixSwagger.Path
  alias PhoenixSwagger.Path.PathObject
  alias PhoenixSwagger.Schema

  # ===== Parameters =====

  def creation_parameters(%PathObject{} = path) do
    Path.parameter(path, :text, :body, :string, "", requried: true)
  end

  def update_parameters(%PathObject{} = path) do
    path
    |> CommonSwagger.id_parameter()
    |> creation_parameters
  end

  # ===== Schemas =====

  def index_schema do
    Schema.items(%Schema{type: :array}, show_schema())
  end

  def show_schema do
    %Schema{type: :object}
    |> Schema.property(:id, :integer, "", required: true)
    |> Schema.property(:userId, :integer, "", required: true)
    |> Schema.property(:username, :string, "", required: true)
    |> Schema.property(:avatar, CommonSwagger.avatar_schema(), "",
      required: true
    )
    |> Schema.property(:createdAt, CommonSwagger.dts_schema(), "",
      required: true
    )
    |> Schema.property(:text, :string, "", required: true)
  end
end
