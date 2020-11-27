defmodule QuenyaUtil.RequestHelper do
  @moduledoc """
  Request helper functions
  """

  def validate_required(v, required?, position) do
    case {required?, v} do
      {true, nil} -> raise(Plug.BadRequestError, "#{v} does not exist in request #{position}")
      _ -> v
    end
  end

  def get_param(conn, name, "path"), do: conn.path_params[name]
  def get_param(conn, name, "query"), do: conn.query_params[name]

  def get_param(conn, name, "header") do
    Enum.reduce_while(conn.req_headers, nil, fn {k, v}, _acc ->
      case k == name do
        true -> {:halt, v}
        _ -> {:cont, nil}
      end
    end)
  end

  def get_param(conn, name, "cookie"), do: conn.cookies[name]

  def get_content_type(conn) do
    v = get_param(conn, "content-type", "header")
    [result | _] = String.split(v, ";")
    result
  end
end
