defmodule NotatwitterWeb.ErrorViewTest do
  @moduledoc false

  use NotatwitterWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert %{errors: ["Not Found"]} =
             render(NotatwitterWeb.ErrorView, "404.json", [])
  end

  test "renders 500.html" do
    assert %{errors: ["Internal Server Error"]} =
             render(NotatwitterWeb.ErrorView, "500.json", [])
  end
end
