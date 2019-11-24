defmodule Notatwitter.Users do
  @moduledoc false

  alias Notatwitter.{Auth, User}
  alias Notatwitter.User.Following
  alias Notatwitter.User.Post
  alias Notatwitter.User.Post.Reply

  defdelegate list_users(), to: User.Manager, as: :list
  defdelegate find_user(id), to: User.Manager, as: :find
  defdelegate register_user(params), to: Auth.UserManager, as: :create
  defdelegate update_user(id, attrs), to: User.Manager, as: :update

  defdelegate list_posts(user_id), to: Post.Manager, as: :list
  defdelegate create_post(user_id, attrs), to: Post.Manager, as: :create
  defdelegate update_post(post_id, attrs), to: Post.Manager, as: :update

  defdelegate list_replies(post_id), to: Reply.Manager, as: :list

  defdelegate create_reply(user_id, post_id, attrs),
    to: Reply.Manager,
    as: :create

  defdelegate update_reply(reply_id, attrs), to: Reply.Manager, as: :update

  defdelegate list_follows(user_id), to: Following.Manager
  defdelegate list_followers(user_id), to: Following.Manager
  defdelegate follow(current_user_id, target_user_id), to: Following.Manager
  defdelegate unfollow(current_user_id, target_user_id), to: Following.Manager
end
