# Version History

## 0.2.1

Bad release for 0.2.0, didn't actually include the stated changed.

## 0.2.0

Implemented reverse range support for `%Easing.AnimationRange`
Fixed impossible range bug (no impossible ranges, always returns empty list)

## 0.1.3

Bug fix: corrected `Easing.AnimationRange.calculate/2` to properly segment based upon frames within the framerate over the given duration

## 0.1.2
* Changed `Easing.AnimationRange.size/1` to calculate an inclusive result

## 0.1.1

* ensure all return values are Float
* ensure that `to_list` and `stream` include the `first` and `last` values precicely
* resolved various Dialyzer warnings

## 0.1.0

* Initial release (Brian Cardarella)