enum MeasureUnit { mm, cm, m, ft, inch }

extension MeasureUnitX on MeasureUnit {
  String get label {
    switch (this) {
      case MeasureUnit.mm:
        return 'mm';
      case MeasureUnit.cm:
        return 'cm';
      case MeasureUnit.m:
        return 'm';
      case MeasureUnit.ft:
        return 'ft';
      case MeasureUnit.inch:
        return 'inch';
    }
  }

  /// convert entered value to MM
  double toMm(double value) {
    switch (this) {
      case MeasureUnit.mm:
        return value;
      case MeasureUnit.cm:
        return value * 10;
      case MeasureUnit.m:
        return value * 1000;
      case MeasureUnit.ft:
        return value * 304.8;
      case MeasureUnit.inch:
        return value * 25.4;
    }
  }
}
