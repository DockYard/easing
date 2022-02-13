defmodule EasingTest do
  use ExUnit.Case
  doctest Easing

  describe "Linear" do
    test "in" do
      assert Easing.run({:linear, :in}, 0) == 0
      assert Easing.run({:linear, :in}, 0.25) == 0.25
      assert Easing.run({:linear, :in}, 0.5) == 0.5
      assert Easing.run({:linear, :in}, 0.75) == 0.75
      assert Easing.run({:linear, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:linear, :out}, 0) == 0
      assert Easing.run({:linear, :out}, 0.25) == 0.25
      assert Easing.run({:linear, :out}, 0.5) == 0.5
      assert Easing.run({:linear, :out}, 0.75) == 0.75
      assert Easing.run({:linear, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:linear, :in_out}, 0) == 0
      assert Easing.run({:linear, :in_out}, 0.25) == 0.25
      assert Easing.run({:linear, :in_out}, 0.5) == 0.5
      assert Easing.run({:linear, :in_out}, 0.75) == 0.75
      assert Easing.run({:linear, :in_out}, 1) == 1
    end
  end

  describe "Sine" do
    test "in" do
      assert Easing.run({:sine, :in}, 0) == 0
      assert Easing.run({:sine, :in}, 0.25) == 0.07612046748871326
      assert Easing.run({:sine, :in}, 0.5) == 0.2928932188134524
      assert Easing.run({:sine, :in}, 0.75) == 0.6173165676349102
      assert Easing.run({:sine, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:sine, :out}, 0) == 0
      assert Easing.run({:sine, :out}, 0.25) == 0.3826834323650898
      assert Easing.run({:sine, :out}, 0.5) == 0.7071067811865475
      assert Easing.run({:sine, :out}, 0.75) == 0.9238795325112867
      assert Easing.run({:sine, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:sine, :in_out}, 0) == 0
      assert Easing.run({:sine, :in_out}, 0.25) == 0.1464466094067262
      assert Easing.run({:sine, :in_out}, 0.5) == 0.49999999999999994
      assert Easing.run({:sine, :in_out}, 0.75) == 0.8535533905932737
      assert Easing.run({:sine, :in_out}, 1) == 1
    end
  end

  describe "Quadratic" do
    test "in" do
      assert Easing.run({:quadratic, :in}, 0) == 0
      assert Easing.run({:quadratic, :in}, 0.25) == 0.0625
      assert Easing.run({:quadratic, :in}, 0.5) == 0.25
      assert Easing.run({:quadratic, :in}, 0.75) == 0.5625
      assert Easing.run({:quadratic, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:quadratic, :out}, 0) == 0
      assert Easing.run({:quadratic, :out}, 0.25) == 0.4375
      assert Easing.run({:quadratic, :out}, 0.5) == 0.75
      assert Easing.run({:quadratic, :out}, 0.75) == 0.9375
      assert Easing.run({:quadratic, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:quadratic, :in_out}, 0) == 0
      assert Easing.run({:quadratic, :in_out}, 0.25) == 0.125
      assert Easing.run({:quadratic, :in_out}, 0.5) == 0.5
      assert Easing.run({:quadratic, :in_out}, 0.75) == 0.875
      assert Easing.run({:quadratic, :in_out}, 1) == 1
    end
  end

  describe "Cubic" do
    test "in" do
      assert Easing.run({:cubic, :in}, 0) == 0
      assert Easing.run({:cubic, :in}, 0.25) == 0.015625
      assert Easing.run({:cubic, :in}, 0.5) == 0.125
      assert Easing.run({:cubic, :in}, 0.75) == 0.421875
      assert Easing.run({:cubic, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:cubic, :out}, 0) == 0
      assert Easing.run({:cubic, :out}, 0.25) == 0.578125
      assert Easing.run({:cubic, :out}, 0.5) == 0.875
      assert Easing.run({:cubic, :out}, 0.75) == 0.984375
      assert Easing.run({:cubic, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:cubic, :in_out}, 0) == 0
      assert Easing.run({:cubic, :in_out}, 0.25) == 0.0625
      assert Easing.run({:cubic, :in_out}, 0.5) == 0.5
      assert Easing.run({:cubic, :in_out}, 0.75) == 0.9375
      assert Easing.run({:cubic, :in_out}, 1) == 1
    end
  end

  describe "Quartic" do
    test "in" do
      assert Easing.run({:quartic, :in}, 0) == 0
      assert Easing.run({:quartic, :in}, 0.25) == 0.00390625
      assert Easing.run({:quartic, :in}, 0.5) == 0.0625
      assert Easing.run({:quartic, :in}, 0.75) == 0.31640625
      assert Easing.run({:quartic, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:quartic, :out}, 0) == 0
      assert Easing.run({:quartic, :out}, 0.25) == 0.68359375
      assert Easing.run({:quartic, :out}, 0.5) == 0.9375
      assert Easing.run({:quartic, :out}, 0.75) == 0.99609375
      assert Easing.run({:quartic, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:quartic, :in_out}, 0) == 0
      assert Easing.run({:quartic, :in_out}, 0.25) == 0.03125
      assert Easing.run({:quartic, :in_out}, 0.5) == 0.5
      assert Easing.run({:quartic, :in_out}, 0.75) == 0.96875
      assert Easing.run({:quartic, :in_out}, 1) == 1
    end
  end

  describe "Quintic" do
    test "in" do
      assert Easing.run({:quintic, :in}, 0) == 0
      assert Easing.run({:quintic, :in}, 0.25) == 0.0009765625
      assert Easing.run({:quintic, :in}, 0.5) == 0.03125
      assert Easing.run({:quintic, :in}, 0.75) == 0.2373046875
      assert Easing.run({:quintic, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:quintic, :out}, 0) == 0
      assert Easing.run({:quintic, :out}, 0.25) == 0.7626953125
      assert Easing.run({:quintic, :out}, 0.5) == 0.96875
      assert Easing.run({:quintic, :out}, 0.75) == 0.9990234375
      assert Easing.run({:quintic, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:quintic, :in_out}, 0) == 0
      assert Easing.run({:quintic, :in_out}, 0.25) == 0.015625
      assert Easing.run({:quintic, :in_out}, 0.5) == 0.5
      assert Easing.run({:quintic, :in_out}, 0.75) == 0.984375
      assert Easing.run({:quintic, :in_out}, 1) == 1
    end
  end

  describe "Exponential" do
    test "in" do
      assert Easing.run({:exponential, :in}, 0) == 0
      assert Easing.run({:exponential, :in}, 0.25) == 0.005524271728019903
      assert Easing.run({:exponential, :in}, 0.5) == 0.03125
      assert Easing.run({:exponential, :in}, 0.75) == 0.1767766952966369
      assert Easing.run({:exponential, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:exponential, :out}, 0) == 0
      assert Easing.run({:exponential, :out}, 0.25) == 0.8232233047033631
      assert Easing.run({:exponential, :out}, 0.5) == 0.96875
      assert Easing.run({:exponential, :out}, 0.75) == 0.99447572827198
      assert Easing.run({:exponential, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:exponential, :in_out}, 0) == 0
      assert Easing.run({:exponential, :in_out}, 0.25) == 0.015625
      assert Easing.run({:exponential, :in_out}, 0.5) == 0.5
      assert Easing.run({:exponential, :in_out}, 0.75) == 0.984375
      assert Easing.run({:exponential, :in_out}, 1) == 1
    end
  end

  describe "Circular" do
    test "in" do
      assert Easing.run({:circular, :in}, 0) == 0
      assert Easing.run({:circular, :in}, 0.25) == 0.031754163448145745
      assert Easing.run({:circular, :in}, 0.5) == 0.1339745962155614
      assert Easing.run({:circular, :in}, 0.75) == 0.3385621722338523
      assert Easing.run({:circular, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:circular, :out}, 0) == 0
      assert Easing.run({:circular, :out}, 0.25) == 0.6614378277661477
      assert Easing.run({:circular, :out}, 0.5) == 0.8660254037844386
      assert Easing.run({:circular, :out}, 0.75) == 0.9682458365518543
      assert Easing.run({:circular, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:circular, :in_out}, 0) == 0
      assert Easing.run({:circular, :in_out}, 0.25) == 0.0669872981077807
      assert Easing.run({:circular, :in_out}, 0.5) == 0.5
      assert Easing.run({:circular, :in_out}, 0.75) == 0.9330127018922193
      assert Easing.run({:circular, :in_out}, 1) == 1
    end
  end

  describe "Back" do
    test "in" do
      assert Easing.run({:back, :in}, 0) == 0
      assert Easing.run({:back, :in}, 0.25) == -0.06413656250000001
      assert Easing.run({:back, :in}, 0.5) == -0.08769750000000004
      assert Easing.run({:back, :in}, 0.75) == 0.1825903124999998
      assert Easing.run({:back, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:back, :out}, 0) == 0
      assert Easing.run({:back, :out}, 0.25) == 0.8174096875000002
      assert Easing.run({:back, :out}, 0.5) == 1.0876975
      assert Easing.run({:back, :out}, 0.75) == 1.0641365625
      assert Easing.run({:back, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:back, :in_out}, 0) == 0
      assert Easing.run({:back, :in_out}, 0.25) == -0.09968184375
      assert Easing.run({:back, :in_out}, 0.5) == 0.5
      assert Easing.run({:back, :in_out}, 0.75) == 1.09968184375
      assert Easing.run({:back, :in_out}, 1) == 1
    end
  end

  describe "Elastic" do
    test "in" do
      assert Easing.run({:elastic, :in}, 0) == 0
      assert Easing.run({:elastic, :in}, 0.25) == -0.005524271728019903
      assert Easing.run({:elastic, :in}, 0.5) == -0.015625000000000045
      assert Easing.run({:elastic, :in}, 0.75) == 0.08838834764831832
      assert Easing.run({:elastic, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:elastic, :out}, 0) == 0
      assert Easing.run({:elastic, :out}, 0.25) == 0.9116116523516816
      assert Easing.run({:elastic, :out}, 0.5) == 1.015625
      assert Easing.run({:elastic, :out}, 0.75) == 1.00552427172802
      assert Easing.run({:elastic, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:elastic, :in_out}, 0) == 0
      assert Easing.run({:elastic, :in_out}, 0.25) == 0.011969444423734044
      assert Easing.run({:elastic, :in_out}, 0.5) == 0.5
      assert Easing.run({:elastic, :in_out}, 0.75) == 0.988030555576266
      assert Easing.run({:elastic, :in_out}, 1) == 1
    end
  end

  describe "Bounce" do
    test "in" do
      assert Easing.run({:bounce, :in}, 0) == 0
      assert Easing.run({:bounce, :in}, 0.25) == 0.02734375
      assert Easing.run({:bounce, :in}, 0.5) == 0.234375
      assert Easing.run({:bounce, :in}, 0.75) == 0.52734375
      assert Easing.run({:bounce, :in}, 1) == 1
    end

    test "out" do
      assert Easing.run({:bounce, :out}, 0) == 0
      assert Easing.run({:bounce, :out}, 0.25) == 0.47265625
      assert Easing.run({:bounce, :out}, 0.5) == 0.765625
      assert Easing.run({:bounce, :out}, 0.75) == 0.97265625
      assert Easing.run({:bounce, :out}, 1) == 1
    end

    test "in out" do
      assert Easing.run({:bounce, :in_out}, 0) == 0
      assert Easing.run({:bounce, :in_out}, 0.25) == 0.1171875
      assert Easing.run({:bounce, :in_out}, 0.5) == 0.5
      assert Easing.run({:bounce, :in_out}, 0.75) == 0.8828125
      assert Easing.run({:bounce, :in_out}, 1) == 1
    end
  end
end
