defmodule QuenyaUtil.RequestHelper do
  @moduledoc """
  Request helper functions
  """

  def validate_required(v, required?, location) do
    case {required?, v} do
      {true, nil} -> raise(Plug.BadRequestError, "#{v} does not exist in request #{location}")
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
end
