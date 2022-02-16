defmodule Easing.AnimationRangeTest do
  use ExUnit.Case
  doctest Easing.AnimationRange
  alias Easing.AnimationRange

  test "animation range produces full range of values" do
    range = %AnimationRange{first: 0, last: 1, step: 0.1}

    list = Enum.to_list(range)

    assert length(list) == 11
    assert Enum.at(list, 0) == 0.0
    assert Enum.at(list, length(list) - 1) == 1.0
  end
end
