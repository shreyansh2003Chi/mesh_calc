import 'dart:math';
import 'package:flutter/material.dart';
import 'package:measurements/utils/measurement_unit.dart';

class HarpWireMeshProvider extends ChangeNotifier {
  final widthOpeningCtrl = TextEditingController();
  final wireDiameterCtrl = TextEditingController();
  final lengthOpeningCtrl = TextEditingController();
  final lengthOpening1Ctrl = TextEditingController();
  final wireDiameter2Ctrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  MeasureUnit widthOpeningUnit = MeasureUnit.mm;
  MeasureUnit wireDiameterUnit = MeasureUnit.mm;
  MeasureUnit lengthOpeningUnit = MeasureUnit.mm;
  MeasureUnit lengthOpening1Unit = MeasureUnit.mm;
  MeasureUnit wireDiameter2Unit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  void clearControllers() {
    widthOpeningCtrl.clear();
    wireDiameterCtrl.clear();
    lengthOpeningCtrl.clear();
    lengthOpening1Ctrl.clear();
    wireDiameter2Ctrl.clear();
    wastageCtrl.clear();
    costCtrl.clear();
    totalWeight = 0;
    totalCost = 0;
  }

  void setWidthOpeningUnit(MeasureUnit u) {
    widthOpeningUnit = u;
    notifyListeners();
  }

  void setWireDiameterUnit(MeasureUnit u) {
    wireDiameterUnit = u;
    notifyListeners();
  }

  void setLengthOpeningUnit(MeasureUnit u) {
    lengthOpeningUnit = u;
    notifyListeners();
  }

  void setLengthOpening1Unit(MeasureUnit u) {
    lengthOpening1Unit = u;
    notifyListeners();
  }
  
  void setWireDiameter2Unit(MeasureUnit u) {
    wireDiameter2Unit = u;
    notifyListeners();
  }

  Future<void> calculate() async {
    final wOpg = widthOpeningUnit.toMm(double.tryParse(widthOpeningCtrl.text) ?? 0);
    final wd1 = wireDiameterUnit.toMm(double.tryParse(wireDiameterCtrl.text) ?? 0);
    final lOpg = lengthOpeningUnit.toMm(double.tryParse(lengthOpeningCtrl.text) ?? 0);
    final lOpg1 = lengthOpening1Unit.toMm(double.tryParse(lengthOpening1Ctrl.text) ?? 0);
    final wd2 = wireDiameter2Unit.toMm(double.tryParse(wireDiameter2Ctrl.text) ?? 0);

    if (wOpg <= 0 || wd1 <= 0 || lOpg <= 0 || lOpg1 <= 0 || wd2 <= 0) {
      totalWeight = 0;
      notifyListeners();
      return;
    }

    // Harp Wire Mesh Open Area Calculation
    // Using an approximation: (W * (L + L1)) / ((W + D) * (L + L1 + d2)) * 100
    double openAreaPercent = (wOpg * (lOpg + lOpg1)) / ((wOpg + wd1) * (lOpg + lOpg1 + wd2)) * 100;

    totalWeight = openAreaPercent; // Reusing totalWeight to display percentage in ResultDialog
    totalCost = 0;

    notifyListeners();
  }
}
