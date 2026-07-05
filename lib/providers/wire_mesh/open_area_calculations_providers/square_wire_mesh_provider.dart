import 'package:flutter/material.dart';
import 'package:measurements/utils/measurement_unit.dart';
import 'dart:math';

class SquareWireMeshProvider extends ChangeNotifier {
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

    // Square Wire Mesh Open Area Calculation using Mesh count
    // Open Area (%) = (1 - (Mesh * Wire Diameter (inches)))^2 * 100
    double dInch = d / 25.4;
    double openAreaPercent = pow((1 - (m * dInch)), 2) * 100;

    // Handle case where wire diameter is larger than pitch
    if (m * dInch >= 1.0) {
      openAreaPercent = 0;
    }

    totalWeight = openAreaPercent;
    totalCost = 0;

    notifyListeners();
  }
}
