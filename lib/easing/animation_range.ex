defmodule Easing.Range do
  @moduledoc """
  Range struct for Easing

  This struct is basically a reimplementation of Elixir's `Range` struct
  but removing the limitations on only working with `Integer` constraints and steps
  """
  defstruct first: nil, last: nil, step: nil

  @one_second 1000

  @type range :: %Easing.Range{first: number(), last: number(), step: number()}

  @spec new(number(), number(), number()) :: range()
  @doc """
  Convenience function for creating a new `Easing.Range` struct

  * first: represents the starting % of the range. Value should be: `value >= 0 and < 1`
  * last: represents the ending % of the range. Value should be: `value > 0 and <= 1`
  * step: value representing what the incremental value is between `first` and `last`. Can represent
  """
  def new(first, last, step) do
    %__MODULE__{first: first, last: last, step: step}
  end

  @spec calculate(integer(), integer()) :: range()
  @doc """
  Creates a new `Easing.Range` struct from a desired  duration and target fps

  * duration_in_ms - total duration of the animation, only accepts `Integer`
  * fps - target frames per second of the animation, only accepts `Integer`

  ## Examples:
      iex> Easing.Range.calculate(1000, 1)
      %Easing.Range{first: 0, last: 1, step: 1.0}
  """
  def calculate(duration_in_ms, fps) when is_integer(duration_in_ms) and is_integer(fps) do
    %__MODULE__{first: 0, last: 1, step: (@one_second / fps) / duration_in_ms}
  end
  def calculate(duration_in_ms, fps) do
    raise ArgumentError, "Easing.Range.calculate/2 can only accept values in Integer form " <>
      "got: (#{duration_in_ms}, #{fps})"
  end

  @spec size(range()) :: integer()
  @doc """
  Returns the size of the `Easing.Range`

  Sizes are *inclusive* across a range. So a range from `0` - `1` with a step of `0.1` will have
  `11` values, not `10` because the `0` value is included in that result.

  ## Examples:
      iex> Easing.Range.calculate(1000, 60) |> Easing.Range.size()
      61
  """
  def size(%{__struct__: __MODULE__, first: first, last: last, step: step}) do
    (abs(:erlang./(last - first, step)) |> Kernel.trunc()) + 1
  end


  defimpl Enumerable, for: Easing.Range do
    def reduce(%{__struct__: Easing.Range, first: first, last: last, step: step}, acc, fun) do
      reduce(first, last, acc, fun, step)
    end

    defp reduce(_first, _last, {:halt, acc}, _fun, _step) do
      {:halted, acc}
    end

    defp reduce(first, last, {:suspend, acc}, fun, step) do
      {:suspended, acc, &reduce(first, last, &1, fun, step)}
    end

    # todo: this is probably shit performance
    defp reduce(first, last, {:cont, acc}, fun, step) do
      cond do
        (step > 0 and first > last) or (step < 0 and first < last) ->
          {:don, acc}
        (step > 0 and Float.ceil(first + 0.0, 10) >= last) or (step < 0 and Float.ceil(first + 0.0, 10) <= last) ->
          {_, acc} = fun.(last, acc)
          {:done, acc}
        true ->
          reduce(first + step, last, fun.(first, acc), fun, step)
      end
    end

    def member?(%{__struct__: Easing.Range, first: first, last: last, step: step} = range, value) do
      cond do
        Easing.Range.size(range) == 0 ->
          {:ok, false}

        first <= last ->
          {:ok, first <= value and value <= last and rem(value - first, step) == 0}

        true ->
          {:ok, last <= value and value <= first and rem(value - first, step) == 0}
      end
    end

    def count(range) do
      {:ok, Easing.Range.size(range)}
    end

    def slice(%{__struct__: Easing.Range, first: first, step: step} = range) do
      {:ok, Easing.Range.size(range), &slice(first + &1 * step, step, &2)}
    end

    defp slice(current, _step, 1), do: [current]
    defp slice(current, step, remaining), do: [current | slice(current + step, step, remaining - 1)]
  end
end
