defmodule Notatwitter.Factory do
  use ExMachina.Ecto, repo: Notatwitter.Repo

  def user_factory do
    %Notatwitter.Auth.User{}
  end

  def profile_factory do
    %Notatwitter.User{}
  end

  def post_factory do
    %Notatwitter.User.Post{}
  end

  def reply_factory do
    %Notatwitter.User.Post.Reply{}
  end

  def following_factory do
    %Notatwitter.User.Following{}
  end
end
