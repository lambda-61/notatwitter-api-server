defmodule NotatwitterWeb.CommonSwagger do
  @moduledoc false

  alias PhoenixSwagger.Path
  alias PhoenixSwagger.Path.PathObject
  alias PhoenixSwagger.Schema

  # ===== Parameters =====

  def requires_authorization(%PathObject{} = path) do
    Path.parameter(
      path,
      "sessionToken",
      :cookie,
      :string,
      "Cookie sessionToken",
      required: true
    )
  end

  def id_parameter(%PathObject{} = path) do
    Path.parameter(path, :id, :path, :string, "Id of an entity", required: true)
  end

  # ===== Schemas =====

  def avatar_schema do
    %Schema{type: :string}
    |> Schema.title("Avatart URL")
    |> Schema.example("http://localhost:4000/uploads/some_image.png")
  end

  def dts_schema do
    %Schema{type: :integer}
    |> Schema.title("Datetime timestamp")
    |> Schema.example("1")
  end
end
