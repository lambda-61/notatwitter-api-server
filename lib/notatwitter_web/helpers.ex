defmodule NotatwitterWeb.Helpers do
  @moduledoc false

  alias Notatwitter.User.Avatar

  def image_url(schema, size) do
    case Avatar.url(schema, size) do
      nil -> nil
      path -> "http://localhost:4000" <> path
    end
  end

  def datetime_to_integer(%NaiveDateTime{} = dt) do
    dt |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix()
  end

  def datetime_to_integer(nil) do
    nil
  end
end
