defmodule NotatwitterWeb.ErrorView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("401.json", %{}) do
    %{errors: ["Unauthorized"]}
  end

  def render("404.json", %{}) do
    %{errors: ["Not Found"]}
  end

  def render("422.json", %{errors: errors}) do
    %{errors: errors}
  end

  def render("422.json", %{changeset: %{errors: errors}}) do
    printable_errors =
      Enum.map(errors, fn {field, {code, _}} ->
        %{code: code, details: field}
      end)

    %{errors: printable_errors}
  end

  def render("500.json", %{reason: reason}) do
    %{
      errors: [
        %{
          code: "Internal Server Error",
          details: Map.from_struct(reason)
        }
      ]
    }
  end
end
