import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class ExpandedMetalProvider with ChangeNotifier {
  final shortWayDiagonalController = TextEditingController();
  final longWayDiagonalController = TextEditingController();
  final strandController = TextEditingController();
  final thicknessController = TextEditingController();
  final widthController = TextEditingController();
  final lengthController = TextEditingController();
  final costPerKg = TextEditingController();

  MeasureUnit shortWayDiagonalUnit = MeasureUnit.mm;
  MeasureUnit longWayDiagonalUnit = MeasureUnit.mm;
  MeasureUnit strandUnit = MeasureUnit.mm;
  MeasureUnit thicknessUnit = MeasureUnit.mm;
  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  MaterialModel selectedMaterial = MaterialModel(
    id: 'al',
    name: 'Aluminium',
    color: Color(0xFFB0BEC5),
    materialConstant: 67,
    density: 2700,
  );

  void setSelectedMaterial(MaterialModel m) {
    selectedMaterial = m;
    notifyListeners();
  }

  void setShortWayDiagonalUnit(MeasureUnit m) {
    shortWayDiagonalUnit = m;
    notifyListeners();
  }

  void setLongWayDiagonalUnit(MeasureUnit m) {
    longWayDiagonalUnit = m;
    notifyListeners();
  }

  void setStrandUnit(MeasureUnit m) {
    strandUnit = m;
    notifyListeners();
  }

  void setThicknessUnit(MeasureUnit m) {
    thicknessUnit = m;
    notifyListeners();
  }

  void setWidthUnit(MeasureUnit m) {
    widthUnit = m;
    notifyListeners();
  }

  void setLengthUnit(MeasureUnit m) {
    lengthUnit = m;
    notifyListeners();
  }

  Future<void> calculate() async {

    final swdMm =
    shortWayDiagonalUnit.toMm(double.tryParse(shortWayDiagonalController.text) ?? 0);

    final lwdMm =
    longWayDiagonalUnit.toMm(double.tryParse(longWayDiagonalController.text) ?? 0);

    final strandMm =
    strandUnit.toMm(double.tryParse(strandController.text) ?? 0);

    final thicknessMm =
    thicknessUnit.toMm(double.tryParse(thicknessController.text) ?? 0);

    final widthM =
        widthUnit.toMm(double.tryParse(widthController.text) ?? 0) / 1000;

    final lengthM =
        lengthUnit.toMm(double.tryParse(lengthController.text) ?? 0) / 1000;

    final costKg = double.tryParse(costPerKg.text) ?? 0;

    if (swdMm <= 0 ||
        lwdMm <= 0 ||
        strandMm <= 0 ||
        thicknessMm <= 0 ||
        widthM <= 0 ||
        lengthM <= 0) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
      return;
    }

    final area = widthM * lengthM;

    // Convert thickness to meters
    final thicknessM = thicknessMm / 1000;

    // Metal ratio approximation
    final metalRatio = strandMm / swdMm;

    // Base sheet weight
    final sheetWeight = selectedMaterial.density * thicknessM * area;

    // Expanded metal weight
    totalWeight = sheetWeight * metalRatio;

    totalCost = totalWeight * costKg;

    notifyListeners();
  }
  void clearControllers() {
    shortWayDiagonalController.clear();
    longWayDiagonalController.clear();
    strandController.clear();
    thicknessController.clear();
    widthController.clear();
    lengthController.clear();
    costPerKg.clear();
    notifyListeners();
  }
}
