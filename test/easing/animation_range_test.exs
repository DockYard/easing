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

  test "reverse ranges work with negative steps" do
    range = %AnimationRange{first: 10, last: 0, step: -1}

    list = Enum.to_list(range)

    assert list == [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  end

  test "impossible ranges result in empty lists" do
    range = %AnimationRange{first: 1, last: 0, step: 1}

    list = Enum.to_list(range)

    assert list == []

    range = %AnimationRange{first: 0, last: 1, step: -1}

    list = Enum.to_list(range)

    assert list == []
  end
end
