defmodule NotatwitterWeb.FollowingSwagger do
  @moduledoc false

  alias NotatwitterWeb.UserSwagger
  alias PhoenixSwagger.Schema

  # ===== Schemas =====

  def users_schema do
    UserSwagger.index_schema()
  end

  def follow_schema do
    %Schema{type: :object}
  end

  def unfollow_schema do
    %Schema{type: :object}
  end
end
