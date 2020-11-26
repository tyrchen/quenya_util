defmodule QuenyaUtilTest do
  use ExUnit.Case
  doctest QuenyaUtil

  test "greets the world" do
    assert QuenyaUtil.hello() == :world
  end
end
