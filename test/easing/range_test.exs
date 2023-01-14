defmodule Easing.RangeTest do
  use ExUnit.Case
  doctest Easing.Range

  test "animation range produces full range of values" do
    range = %Easing.Range{first: 0, last: 1, step: 0.1}

    list = Enum.to_list(range)

    assert length(list) == 12
    assert Enum.at(list, 0) == 0.0
    assert Enum.at(list, length(list) - 1) == 1.0

    range = %Easing.Range{first: 0, last: 10, step: 3}

    list = Enum.to_list(range)

    assert list == [0, 3, 6, 9, 10]
  end

  test "reverse ranges work with negative steps" do
    range = %Easing.Range{first: 10, last: 0, step: -1}

    list = Enum.to_list(range)

    assert list == [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  end

  test "impossible ranges result in empty lists" do
    range = %Easing.Range{first: 1, last: 0, step: 1}

    list = Enum.to_list(range)

    assert list == []

    range = %Easing.Range{first: 0, last: 1, step: -1}

    list = Enum.to_list(range)

    assert list == []
  end

  test "range can safely expand impossible ranges" do
    range = %Easing.Range{first: 0, last: 5, step: -1}

    result =
      range
      |> Stream.map(&(&1*2))
      |> Enum.to_list()

    assert result == []
  end
end
