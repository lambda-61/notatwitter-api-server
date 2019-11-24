defmodule Notatwitter.User.Avatar do
  @moduledoc false

  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:max, :big, :small]

  def transform(:small, _) do
    attrs = "-gravity center -resize 300x300^ -crop 300x300+0+0 -format png"
    {:convert, attrs, :png}
  end

  def transform(:big, _) do
    attrs = "-gravity center -resize 500x500^ -crop 500x500+0+0 -format png"
    {:convert, attrs, :png}
  end

  def transform(:max, _) do
    attrs = "-gravity center -resize 700x700^ -crop 700x700+0+0 -format png"
    {:convert, attrs, :png}
  end

  def filename(version, {file, _scope}) do
    "#{file.file_name}_#{version}"
  end
end
