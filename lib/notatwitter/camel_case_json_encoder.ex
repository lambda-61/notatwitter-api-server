defmodule Notatwitter.CamelCaseJSONEncoder do
  @moduledoc false

  use ProperCase.JSONEncoder,
    transform: &ProperCase.to_camel_case/1,
    json_encoder: Jason
end
