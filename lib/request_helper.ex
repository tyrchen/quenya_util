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

  def get_param(conn, name, position) when position in ["header", "resp_header"] do
    headers =
      case position do
        "header" -> conn.req_headers
        "resp_header" -> conn.resp_headers
      end

    name = String.downcase(name)

    Enum.reduce_while(headers, nil, fn {k, v}, _acc ->
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

  def get_accept(conn) do
    conn
    |> get_param("accept", "header")
    |> String.split(",")
    |> Enum.map(fn part ->
      [result | _] = part |> String.trim() |> String.split(";")
      result
    end)
  end
end
