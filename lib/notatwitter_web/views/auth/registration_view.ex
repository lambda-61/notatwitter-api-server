defmodule NotatwitterWeb.Auth.RegistrationView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("created.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username
    }
  end
end
