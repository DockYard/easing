defmodule Easing.AnimationRange do
  @moduledoc """
  Animation range struct for Easing

  This struct is basically a reimplementation of Elixir's `Range` struct
  but removing the limitations on only working with `Integer` constraints and steps
  """
  defstruct first: nil, last: nil, step: nil

  @type animation_range :: %Easing.AnimationRange{first: number(), last: number(), step: number()}

  @spec new(number(), number(), number()) :: animation_range()
  @doc """
  Convenience function for creating a new `Easing.AnimationRange` struct

  * first: represents the starting % of the animation range. Value should be: `value >= 0 and < 1`
  * last: represents the ending % of the animation range. Value should be: `value > 0 and <= 1`
  * step: value representing what the incremental value is between `first` and `last`. Can represent
  """
  def new(first, last, step) do
    %__MODULE__{first: first, last: last, step: step}
  end

  @spec calculate(integer(), integer()) :: animation_range()
  @doc """
  Creates a new `Easing.AnimationRange` struct from a desires animation duration and target fps

  * duration_in_ms - total duration of the animation, only accepts `Integer`
  * fps - target frames per second of the animation, only accepts `Integer`

  ## Examples:
      iex> Easing.AnimationRange.calculate(100, 1)
      %Easing.AnimationRange{first: 0, last: 1, step: 0.01}
  """
  def calculate(duration_in_ms, fps) when is_integer(duration_in_ms) and is_integer(fps) do
    %__MODULE__{first: 0, last: 1, step: 1 / duration_in_ms / fps}
  end
  def calculate(duration_in_ms, fps) do
    raise ArgumentError, "Easing.AnimationRange.calculate/2 can only accept values in Integer form " <>
      "got: (#{duration_in_ms}, #{fps})"
  end

  @spec size(animation_range()) :: integer()
  @doc """
  Returns the size of the `Easing.AnimationRange`

  ## Examples:
      iex> Easing.AnimationRange.calculate(1000, 60) |> Easing.AnimationRange.size()
      60_000
  """
  def size(%{__struct__: __MODULE__, first: first, last: last, step: step}) do
    abs(:erlang./(last - first, step)) |> Kernel.trunc()
  end


  defimpl Enumerable, for: Easing.AnimationRange do
    def reduce(%{__struct__: Easing.AnimationRange, first: first, last: last, step: step}, acc, fun) do
      reduce(first, last, acc, fun, step)
    end

    defp reduce(_first, _last, {:halt, acc}, _fun, _step) do
      {:halted, acc}
    end

    defp reduce(first, last, {:suspend, acc}, fun, step) do
      {:suspended, acc, &reduce(first, last, &1, fun, step)}
    end

    defp reduce(first, last, {:cont, acc}, fun, step) do
      cond do
        Float.ceil(first + 0.0, 10) >= last ->
          {_, acc} = fun.(last, acc)
          {:done, acc}
        true ->
          reduce(first + step, last, fun.(first, acc), fun, step)
      end
    end

    def member?(%{__struct__: Easing.AnimationRange, first: first, last: last, step: step} = range, value) do
      cond do
        Easing.AnimationRange.size(range) == 0 ->
          {:ok, false}

        first <= last ->
          {:ok, first <= value and value <= last and rem(value - first, step) == 0}

        true ->
          {:ok, last <= value and value <= first and rem(value - first, step) == 0}
      end
    end

    def count(range) do
      {:ok, Easing.AnimationRange.size(range)}
    end

    def slice(%{__struct__: Easing.AnimationRange, first: first, step: step} = range) do
      {:ok, Easing.AnimationRange.size(range), &slice(first + &1 * step, step, &2)}
    end

    defp slice(current, _step, 1), do: [current]
    defp slice(current, step, remaining), do: [current | slice(current + step, step, remaining - 1)]
  end
end
