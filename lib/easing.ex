defmodule Easing do
  @moduledoc """
  Easing function calculations

  Cribbed from: https://easings.net/
  """

  alias Easing.AnimationRange

  @type easing_tuple :: {atom(), atom()}
  @type animation_range :: %Easing.AnimationRange{first: number(), last: number(), step: number()}
  @type easing_function :: function()
  @type easing_function_or_tuple :: easing_function() | easing_tuple()
  @type easings :: [float()]


  @spec to_list(animation_range(), easing_function_or_tuple()) :: easings()
  @doc """
  Generates a list of animation frame values.

  A `Range` is used for the `animation_range` argument. See the example

  ## Examples:

      iex> Easing.to_list(%Easing.AnimationRange{first: 0, last: 1, step: 0.1}, &Easing.sine_in(&1))
      [0.0, 0.01231165940486223, 0.04894348370484647, 0.10899347581163221, 0.19098300562505255, 0.2928932188134524, 0.41221474770752675, 0.5460095002604533, 0.6909830056250525, 0.8435655349597688, 1.0]

      iex> Easing.to_list(%Easing.AnimationRange{first: 0, last: 0.5, step: 0.1}, {:bounce, :in_out})
      [0.0, 0.030000000000000027, 0.11375000000000002, 0.04499999999999993, 0.3487500000000001, 0.5]
  """
  def to_list(%AnimationRange{} = animation_range, easing) do
    animation_range
    |> stream(easing)
    |> Enum.to_list()
  end

  @spec stream(animation_range(), easing_function_or_tuple()) :: Enumerable.t()
  @doc """
  Generates a stream of animation frame values.

  A `Range` is used for the `animation_range` argument. See the example

  ## Examples:
      iex> Easing.stream(%Easing.AnimationRange{first: 0, last: 1, step: 0.1}, &Easing.sine_in(&1)) |> Enum.to_list()
      [0.0, 0.01231165940486223, 0.04894348370484647, 0.10899347581163221, 0.19098300562505255, 0.2928932188134524, 0.41221474770752675, 0.5460095002604533, 0.6909830056250525, 0.8435655349597688, 1.0]

      iex> Easing.stream(%Easing.AnimationRange{first: 0, last: 0.5, step: 0.1}, {:bounce, :in_out}) |> Enum.to_list()
      [0.0, 0.030000000000000027, 0.11375000000000002, 0.04499999999999993, 0.3487500000000001, 0.5]

  """
  def stream(%AnimationRange{} = animation_range, easing_function) when is_function(easing_function) do
    Stream.map(animation_range, &easing_function.(&1))
  end
  def stream(%AnimationRange{} = animation_range, easing_tuple) when is_tuple(easing_tuple) do
    Stream.map(animation_range, &run(easing_tuple, &1))
  end

  @spec linear_in(float()) :: float()
  @doc """
  Linear in easing function

  ## Example

      iex> Easing.linear_in(0.1)
      0.1
  """
  def linear_in(progress), do: run({:linear, :in}, progress)

  @spec linear_out(float()) ::float()
  @doc """
  Linear out easing function

  ## Example

      iex> Easing.linear_out(0.1)
      0.1
  """
  def linear_out(progress), do: run({:linear, :out}, progress)

  @spec linear_in_out(float()) :: float()
  @doc """
  Linear in-out easing function

  ## Example

      iex> Easing.linear_in_out(0.1)
      0.1
  """
  def linear_in_out(progress), do: run({:linear, :in_out}, progress)

  @spec sine_in(float()) :: float()
  @doc """
  Sine in easing function

  ![Sine in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/sine/in.png "Sine in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.sine_in(0.1)
      0.01231165940486223
  """
  def sine_in(progress), do: run({:sine, :in}, progress)

  @spec sine_out(float()) :: float()
  @doc """
  Sine out easing function

  ![Sine out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/sine/out.png "Sine out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.sine_out(0.1)
      0.15643446504023087
  """
  def sine_out(progress), do: run({:sine, :out}, progress)

  @spec sine_in_out(float()) :: float()
  @doc """
  Sine in-out easing function

  ![Sine in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/sine/in_out.png "Sine in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.sine_in_out(0.1)
      0.024471741852423234
  """
  def sine_in_out(progress), do: run({:sine, :in_out}, progress)

  @spec quadratic_in(float()) :: float()
  @doc """
  Quadratic in easing function

  ![Quadratic in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quadratic/in.png "Quadratic in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quadratic_in(0.1)
      0.010000000000000002
  """
  def quadratic_in(progress), do: run({:quadratic, :in}, progress)

  @spec quadratic_out(float()) :: float()
  @doc """
  Quadratic out easing function

  ![Quadratic out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quadratic/out.png "Quadratic out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quadratic_out(0.1)
      0.18999999999999995
  """
  def quadratic_out(progress), do: run({:quadratic, :out}, progress)

  @spec quadratic_in_out(float()) :: float()
  @doc """
  Quadratic in-out easing function

  ![Quadratic in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quadratic/in_out.png "Quadratic in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quadratic_in_out(0.1)
      0.020000000000000004
  """
  def quadratic_in_out(progress), do: run({:quadratic, :in_out}, progress)

  @spec cubic_in(float()) :: float()
  @doc """
  Cubic in easing function

  ![Cubic in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/cubic/in.png "Cubic in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.cubic_in(0.1)
      0.0010000000000000002
  """
  def cubic_in(progress), do: run({:cubic, :in}, progress)

  @spec cubic_out(float()) :: float()
  @doc """
  Cubic out easing function

  ![Cubic out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/cubic/out.png "Cubic out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.cubic_out(0.1)
      0.2709999999999999
  """
  def cubic_out(progress), do: run({:cubic, :out}, progress)

  @spec cubic_in_out(float()) :: float()
  @doc """
  Cubic in-out easing function

  ![Cubic in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/cubic/in_out.png "Cubic in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.cubic_in_out(0.1)
      0.004000000000000001
  """
  def cubic_in_out(progress), do: run({:cubic, :in_out}, progress)

  @spec quartic_in(float()) :: float()
  @doc """
  Quartic in easing function

  ![Quartic in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quartic/in.png "Quartic in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quartic_in(0.1)
      1.0000000000000002e-4
  """
  def quartic_in(progress), do: run({:quartic, :in}, progress)

  @spec quartic_out(float()) :: float()
  @doc """
  Quartic out easing function

  ![Quartic out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quartic/out.png "Quartic out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quartic_out(0.1)
      0.3439
  """
  def quartic_out(progress), do: run({:quartic, :out}, progress)

  @spec quartic_in_out(float()) :: float()
  @doc """
  Quartic in-out easing function

  ![Quartic in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quartic/in_out.png "Quartic in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quartic_in_out(0.1)
      8.000000000000001e-4
  """
  def quartic_in_out(progress), do: run({:quartic, :in_out}, progress)

  @spec quintic_in(float()) :: float()
  @doc """
  Quintic in easing function

  ![Quintic in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quintic/in.png "Quintic in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quintic_in(0.1)
      1.0000000000000003e-5
  """
  def quintic_in(progress), do: run({:quintic, :in}, progress)

  @spec quintic_out(float()) :: float()
  @doc """
  Quintic out easing function

  ![Quintic out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quintic/out.png "Quintic out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quintic_out(0.1)
      0.40950999999999993
  """
  def quintic_out(progress), do: run({:quintic, :out}, progress)

  @spec quintic_in_out(float()) :: float()
  @doc """
  Quintic in-out easing function

  ![Quintic in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/quintic/in_out.png "Quintic in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.quintic_in_out(0.1)
      1.6000000000000004e-4
  """
  def quintic_in_out(progress), do: run({:quintic, :in_out}, progress)

  @spec exponential_in(float()) :: float()
  @doc """
  Exponential in easing function

  ![Exponential in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/exponential/in.png "Expoenential in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.exponential_in(0.1)
      0.001953125
  """
  def exponential_in(progress), do: run({:exponential, :in}, progress)

  @spec exponential_out(float()) :: float()
  @doc """
  Exponential out easing function

  ![Exponential out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/exponential/out.png "Expoenential out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.exponential_out(0.1)
      0.5
  """
  def exponential_out(progress), do: run({:exponential, :out}, progress)

  @spec exponential_in_out(float()) :: float()
  @doc """
  Exponential in-out easing function

  ![Exponential in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/exponential/in_out.png "Expoenential in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.exponential_in_out(0.1)
      0.001953125
  """
  def exponential_in_out(progress), do: run({:exponential, :in_out}, progress)

  @spec circular_in(float()) :: float()
  @doc """
  Circular in easing function

  ![Circular in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/circular/in.png "Circular in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.circular_in(0.1)
      0.005012562893380035
  """
  def circular_in(progress), do: run({:circular, :in}, progress)

  @spec circular_out(float()) :: float()
  @doc """
  Circular out easing function

  ![Circular out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/circular/out.png "Circular out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.circular_out(0.1)
      0.4358898943540673
  """
  def circular_out(progress), do: run({:circular, :out}, progress)

  @spec circular_in_out(float()) :: float()
  @doc """
  Circular in-out easing function

  ![Circular in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/circular/in_out.png "Circular in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.circular_in_out(0.1)
      0.010102051443364402
  """
  def circular_in_out(progress), do: run({:circular, :in_out}, progress)

  @spec back_in(float()) :: float()
  @doc """
  Back in easing function

  ![Back in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/back/in.png "Back in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.back_in(0.1)
      -0.014314220000000004
  """
  def back_in(progress), do: run({:back, :in}, progress)

  @spec back_out(float()) :: float()
  @doc """
  Back out easing function

  ![Back out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/back/out.png "Back out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.back_out(0.1)
      0.40882797999999987
  """
  def back_out(progress), do: run({:back, :out}, progress)

  @spec back_in_out(float()) :: float()
  @doc """
  Back in-out easing function

  ![Back in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/back/in_out.png "Back in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.back_in_out(0.1)
      -0.037518552000000004
  """
  def back_in_out(progress), do: run({:back, :in_out}, progress)

  @spec elastic_in(float()) :: float()
  @doc """
  Elastic in easing function

  ![Elastic in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/elastic/in.png "Elastic in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.elastic_in(0.1)
      0.001953125
  """
  def elastic_in(progress), do: run({:elastic, :in}, progress)

  @spec elastic_out(float()) :: float()
  @doc """
  Elastic out easing function

  ![Elastic out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/elastic/out.png "Elastic out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.elastic_out(0.1)
      1.25
  """
  def elastic_out(progress), do: run({:elastic, :out}, progress)

  @spec elastic_in_out(float()) :: float()
  @doc """
  Elastic in-out easing function

  ![Elastic in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/elastic/in_out.png "Elastic in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.elastic_in_out(0.1)
      3.39156597005722e-4
  """
  def elastic_in_out(progress), do: run({:elastic, :in_out}, progress)

  @spec bounce_in(float()) :: float()
  @doc """
  Bounce in easing function

  ![Bounce in easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/bounce/in.png "Bounce in easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.bounce_in(0.1)
      0.01187500000000008
  """
  def bounce_in(progress), do: run({:bounce, :in}, progress)

  @spec bounce_out(float()) :: float()
  @doc """
  Bounce out easing function

  ![Bounce out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/bounce/out.png "Bounce out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.bounce_out(0.1)
      0.07562500000000001
  """
  def bounce_out(progress), do: run({:bounce, :out}, progress)

  @spec bounce_in_out(float()) :: float()
  @doc """
  Bounce in-out easing function

  ![Bounce in-out easing visualizations created by Andrey Sitnik and Ivan Solovev](assets/images/bounce/in_out.png "Bounce in-out easing visulizations created by Andrey Sitnik and Ivan Solovev")

  ## Example

      iex> Easing.bounce_in_out(0.1)
      0.030000000000000027
  """
  def bounce_in_out(progress), do: run({:bounce, :in_out}, progress)

  @spec run(easing_function_or_tuple(), float()) :: float()
  @doc """
  Easing calculation. Take a tupal of atoms `{direction, type}` and the progress is a value
  between 0 - 1 that represents the animation progress. (0 = beginning, 1 = end)

  * directions: `:in`, `:out`, and `:in_out`
  * types: `:sine`, `:quadratic`, `:cubic`, `:quartic`, `:quintic`, :`exponential`, `:circular`, `:back`, `:elastic`, `:bounce`
  * progress: value between `0` and `1` that represents the % of the animation state.
  * options: keyword list
    - round: `true` - will round the result up with a precision of 2
  """
  def run(easing_function, progress) do
    cond do
      progress == 0 -> 0.0
      progress == 1 -> 1.0
      true -> do_run(easing_function, progress)
    end
  end

  # Linear

  defp do_run({:linear, _direction}, progress), do: progress

  # Sine

  defp do_run({:sine, :in}, progress) do
    1 - :math.cos((progress * :math.pi()) / 2)
  end

  defp do_run({:sine, :out}, progress) do
    :math.sin((progress * :math.pi()) / 2)
  end

  defp do_run({:sine, :in_out}, progress) do
    -1 * (:math.cos(:math.pi() * progress) - 1) / 2
  end

  # Quadratic

  defp do_run({:quadratic, :in}, progress) do
    :math.pow(progress, 2)
  end

  defp do_run({:quadratic, :out}, progress) do
    1 - (1 - progress) * (1 - progress)
  end

  defp do_run({:quadratic, :in_out}, progress) do
    if progress < 0.5 do
      2 * :math.pow(progress, 2)
    else
      1 - :math.pow(-2 * progress + 2, 2) / 2
    end
  end

  # Cubic

  defp do_run({:cubic, :in}, progress) do
    :math.pow(progress, 3)
  end

  defp do_run({:cubic, :out}, progress) do
    1 - :math.pow(1 - progress, 3)
  end

  defp do_run({:cubic, :in_out}, progress) do
    if progress < 0.5 do
      4 * :math.pow(progress, 3)
    else
      1 - :math.pow(-2 * progress + 2, 3) / 2
    end
  end

  # Quartic

  defp do_run({:quartic, :in}, progress) do
    :math.pow(progress, 4)
  end

  defp do_run({:quartic, :out}, progress) do
    1 - :math.pow(1 - progress, 4)
  end

  defp do_run({:quartic, :in_out}, progress) do
    if progress < 0.5 do
      8 * :math.pow(progress, 4)
    else
      1 - :math.pow(-2 * progress + 2, 4) / 2
    end
  end

  # Quintic

  defp do_run({:quintic, :in}, progress) do
    :math.pow(progress, 5)
  end

  defp do_run({:quintic, :out}, progress) do
    1 - :math.pow(1 - progress, 5)
  end

  defp do_run({:quintic, :in_out}, progress) do
    if progress < 0.5 do
      16 * :math.pow(progress, 5)
    else
      1 - :math.pow(-2 * progress + 2, 5) / 2
    end
  end

  # Exponential

  defp do_run({:exponential, :in}, progress) do
    :math.pow(2, 10 * progress - 10)
  end

  defp do_run({:exponential, :out}, progress) do
    1 - :math.pow(2, -10 * progress)
  end

  defp do_run({:exponential, :in_out}, progress) do
    cond do
      progress < 0.5 -> :math.pow(2, 20 * progress - 10) / 2
      true -> (2 - :math.pow(2, -20 * progress + 10)) / 2
    end
  end

  # Circular

  defp do_run({:circular, :in}, progress) do
    1 - :math.sqrt(1 - :math.pow(progress, 2))
  end

  defp do_run({:circular, :out}, progress) do
    :math.sqrt(1 - :math.pow(progress - 1, 2))
  end

  defp do_run({:circular, :in_out}, progress) do
    if progress < 0.5 do
      (1 - :math.sqrt(1 - :math.pow(2 * progress, 2))) / 2
    else
      (:math.sqrt(1 - :math.pow(-2 * progress + 2, 2)) + 1) / 2
    end
  end

  # Back

  defp do_run({:back, :in}, progress) do
    c1 = 1.70158
    c3 = c1 + 1

    c3 * :math.pow(progress, 3) - c1 * :math.pow(progress, 2)
  end

  defp do_run({:back, :out}, progress) do
    c1 = 1.70158
    c3 = c1 + 1

    1 + c3 * :math.pow(progress - 1, 3) + c1 * :math.pow(progress - 1, 2)
  end

  defp do_run({:back, :in_out}, progress) do
    c1 = 1.70158
    c2 = c1 * 1.525

    if progress < 0.5 do
      (:math.pow(2 * progress, 2) * ((c2 + 1) * 2 * progress - c2)) /2
    else
      (:math.pow(2 * progress - 2, 2) * ((c2 + 1) * (progress * 2 - 2) + c2) + 2) / 2
    end
  end

  # Elastic

  defp do_run({:elastic, :in}, progress) do
    c4 = (2 * :math.pi()) / 3

    -1 * :math.pow(2, 10 * progress - 10) * :math.sin((progress * 10 - 10.75) * c4)
  end

  defp do_run({:elastic, :out}, progress) do
    c4 = (2 * :math.pi()) / 3;

    :math.pow(2, -10 * progress) * :math.sin((progress * 10 - 0.75) * c4) + 1
  end

  defp do_run({:elastic, :in_out}, progress) do
    c5 = (2 * :math.pi()) / 4.5

    cond do
      progress < 0.5 -> -1 * (:math.pow(2, 20 * progress - 10) * :math.sin((20 * progress - 11.125) * c5)) / 2
      true -> (:math.pow(2, -20 * progress + 10) * :math.sin((20 * progress - 11.125) * c5)) / 2 + 1
    end
  end

  # Bounce

  defp do_run({:bounce, :in}, progress) do
    1.0 - run({:bounce, :out}, 1.0 - progress)
  end

  defp do_run({:bounce, :out}, progress) do
    n1 = 7.5625
    d1 = 2.75

    cond do
      progress < 1 / d1 -> n1 * :math.pow(progress, 2)
      progress < 2 / d1 ->
        p1 = progress - 1.5 / d1
        n1 * :math.pow(p1, 2) + 0.75
      progress < 2.5 / d1 ->
        p2 = progress - 2.25 / d1
        n1 * :math.pow(p2, 2) + 0.9375
      true ->
        p3 = progress - 2.625 / d1
        n1 * :math.pow(p3, 2) + 0.984375
    end
  end

  defp do_run({:bounce, :in_out}, progress) do
    if progress < 0.5 do
      (1 - run({:bounce, :out}, 1 - 2 * progress)) / 2
    else
      (1 + run({:bounce, :out}, 2 * progress - 1)) / 2
    end
  end
end
