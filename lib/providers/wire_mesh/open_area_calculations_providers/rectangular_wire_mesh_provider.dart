import 'package:flutter/material.dart';
import 'package:measurements/utils/measurement_unit.dart';

class RectangularWireMeshProvider extends ChangeNotifier {
  final widthMeshCtrl = TextEditingController();
  final wireDiameter1Ctrl = TextEditingController();
  final lengthMeshCtrl = TextEditingController();
  final wireDiameter2Ctrl = TextEditingController();

  MeasureUnit widthMeshUnit = MeasureUnit.mm;
  MeasureUnit wireDiameter1Unit = MeasureUnit.mm;
  MeasureUnit lengthMeshUnit = MeasureUnit.mm;
  MeasureUnit wireDiameter2Unit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  void clearControllers() {
    widthMeshCtrl.clear();
    wireDiameter1Ctrl.clear();
    lengthMeshCtrl.clear();
    wireDiameter2Ctrl.clear();
    totalWeight = 0;
    totalCost = 0;
    notifyListeners();
  }

  void setWidthMeshUnit(MeasureUnit u) {
    widthMeshUnit = u;
    notifyListeners();
  }

  void setWireDiameter1Unit(MeasureUnit u) {
    wireDiameter1Unit = u;
    notifyListeners();
  }

  void setLengthMeshUnit(MeasureUnit u) {
    lengthMeshUnit = u;
    notifyListeners();
  }

  void setWireDiameter2Unit(MeasureUnit u) {
    wireDiameter2Unit = u;
    notifyListeners();
  }

  Future<void> calculate() async {
    final wm = widthMeshUnit.toMm(double.tryParse(widthMeshCtrl.text) ?? 0);
    final wd1 = wireDiameter1Unit.toMm(double.tryParse(wireDiameter1Ctrl.text) ?? 0);
    final lm = lengthMeshUnit.toMm(double.tryParse(lengthMeshCtrl.text) ?? 0);
    final wd2 = wireDiameter2Unit.toMm(double.tryParse(wireDiameter2Ctrl.text) ?? 0);

    if (wm <= 0 || wd1 <= 0 || lm <= 0 || wd2 <= 0) {
      totalWeight = 0;
      notifyListeners();
      return;
    }

    // Rectangular Wire Mesh Open Area Calculation
    // (Width * Length) / ((Width + WireDiameter1) * (Length + WireDiameter2)) * 100
    double openAreaPercent = (wm * lm) / ((wm + wd1) * (lm + wd2)) * 100;

    totalWeight = openAreaPercent;
    totalCost = 0;

    notifyListeners();
  }
}
