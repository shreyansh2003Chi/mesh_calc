import 'package:flutter/material.dart';
import 'package:measurements/utils/measurement_unit.dart';

class MeshCalculationProvider extends ChangeNotifier {
  final openingCtrl = TextEditingController();
  final wireDiameterCtrl = TextEditingController();

  MeasureUnit openingUnit = MeasureUnit.mm;
  MeasureUnit wireDiameterUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  void clearControllers() {
    openingCtrl.clear();
    wireDiameterCtrl.clear();
    totalWeight = 0;
    totalCost = 0;
    notifyListeners();
  }

  void setOpeningUnit(MeasureUnit u) {
    openingUnit = u;
    notifyListeners();
  }

  void setWireDiameterUnit(MeasureUnit u) {
    wireDiameterUnit = u;
    notifyListeners();
  }

  Future<void> calculate() async {
    final o = openingUnit.toMm(double.tryParse(openingCtrl.text) ?? 0);
    final d = wireDiameterUnit.toMm(double.tryParse(wireDiameterCtrl.text) ?? 0);

    if (o <= 0 || d <= 0) {
      totalWeight = 0;
      notifyListeners();
      return;
    }

    // Mesh = 25.4 / (Opening + WireDiameter)
    double meshValue = 25.4 / (o + d);

    totalWeight = meshValue; 
    totalCost = 0;

    notifyListeners();
  }
}
