import 'package:flutter/material.dart';
import 'package:measurements/utils/measurement_unit.dart';

class WiresRequiredWwProvider with ChangeNotifier {
  final widthOpeningCtrl = TextEditingController();
  final wireDiameterWidthCtrl = TextEditingController();
  final lengthOpeningCtrl = TextEditingController();
  final wireDiameterLengthCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();

  double numberOfLineWires = 0;
  double numberOfCrossWires = 0;

  MeasureUnit widthOpeningUnit = MeasureUnit.mm;
  MeasureUnit widthDiameterUnit = MeasureUnit.mm;
  MeasureUnit lengthOpeningUnit = MeasureUnit.mm;
  MeasureUnit lengthDiameterUnit = MeasureUnit.mm;
  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  void clearController() {
    widthOpeningCtrl.clear();
    wireDiameterWidthCtrl.clear();
    lengthOpeningCtrl.clear();
    wireDiameterLengthCtrl.clear();
    widthCtrl.clear();
    lengthCtrl.clear();

    numberOfLineWires = 0;
    numberOfCrossWires = 0;
    notifyListeners();
  }

  void setWidthOpeningUnit(MeasureUnit unit) { widthOpeningUnit = unit; notifyListeners(); }
  void setWidthDiameterUnit(MeasureUnit unit) { widthDiameterUnit = unit; notifyListeners(); }
  void setLengthOpeningUnit(MeasureUnit unit) { lengthOpeningUnit = unit; notifyListeners(); }
  void setLengthDiameterUnit(MeasureUnit unit) { lengthDiameterUnit = unit; notifyListeners(); }
  void setWidthUnit(MeasureUnit unit) { widthUnit = unit; notifyListeners(); }
  void setLengthUnit(MeasureUnit unit) { lengthUnit = unit; notifyListeners(); }

  void calculate() {
    final double wOpg = widthOpeningUnit.toMm(double.tryParse(widthOpeningCtrl.text) ?? 0) / 1000;
    final double wwd = widthDiameterUnit.toMm(double.tryParse(wireDiameterWidthCtrl.text) ?? 0) / 1000;
    final double lOpg = lengthOpeningUnit.toMm(double.tryParse(lengthOpeningCtrl.text) ?? 0) / 1000;
    final double lwd = lengthDiameterUnit.toMm(double.tryParse(wireDiameterLengthCtrl.text) ?? 0) / 1000;
    final double widthM = widthUnit.toMm(double.tryParse(widthCtrl.text) ?? 0) / 1000;
    final double lengthM = lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000;

    final double pitchWidth = wOpg + wwd;
    final double pitchLength = lOpg + lwd;

    if (pitchWidth <= 0 || pitchLength <= 0 || widthM <= 0 || lengthM <= 0) {
      numberOfLineWires = 0;
      numberOfCrossWires = 0;
      notifyListeners();
      return;
    }

    numberOfLineWires = (widthM / pitchWidth).ceil() + 1;
    numberOfCrossWires = (lengthM / pitchLength).ceil() + 1;

    notifyListeners();
  }

  @override
  void dispose() {
    widthOpeningCtrl.dispose();
    wireDiameterWidthCtrl.dispose();
    lengthOpeningCtrl.dispose();
    wireDiameterLengthCtrl.dispose();
    widthCtrl.dispose();
    lengthCtrl.dispose();
    super.dispose();
  }
}
