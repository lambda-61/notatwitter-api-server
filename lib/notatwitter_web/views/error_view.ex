defmodule NotatwitterWeb.ErrorView do
  use NotatwitterWeb, :view

  def render("401.json", %{error: error}) do
    %{error: error}
  end
end
