import 'package:flutter/material.dart';
import 'package:measurements/utils/measurement_unit.dart';

class OpeningCalculationProvider extends ChangeNotifier {
  final meshCtrl = TextEditingController();
  final wireDiameterCtrl = TextEditingController();

  MeasureUnit wireDiameterUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  void clearControllers() {
    meshCtrl.clear();
    wireDiameterCtrl.clear();
    totalWeight = 0;
    totalCost = 0;
    notifyListeners();
  }

  void setWireDiameterUnit(MeasureUnit u) {
    wireDiameterUnit = u;
    notifyListeners();
  }

  Future<void> calculate() async {
    final m = double.tryParse(meshCtrl.text) ?? 0;
    final d = wireDiameterUnit.toMm(double.tryParse(wireDiameterCtrl.text) ?? 0);

    if (m <= 0 || d <= 0) {
      totalWeight = 0;
      notifyListeners();
      return;
    }

    // Opening (mm) = (25.4 / Mesh) - WireDiameter(mm)
    double openingValue = (25.4 / m) - d;
    if (openingValue < 0) openingValue = 0;

    totalWeight = openingValue; 
    totalCost = 0;

    notifyListeners();
  }
}
