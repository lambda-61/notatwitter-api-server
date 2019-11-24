defmodule NotatwitterWeb.ErrorView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("401.json", %{error: error}) do
    %{error: error}
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

  def render("500.json", %{}) do
    %{errors: ["Internal Server Error"]}
  end
end
