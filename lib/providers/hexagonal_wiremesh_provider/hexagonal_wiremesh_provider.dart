import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class HexagonalWiremeshProvider with ChangeNotifier {
  final wireDiameterController = TextEditingController();
  final widthController = TextEditingController();
  final lengthController = TextEditingController();
  final wastageController = TextEditingController();
  final costPerKgController = TextEditingController();

  MaterialModel selectedMaterial = MaterialModel(
    id: 'al',
    name: 'Aluminium',
    color: Color(0xFFB0BEC5),
    materialConstant: 67,
    density: 2700,
  );

  MeasureUnit wireDiameterUnit = MeasureUnit.mm;
  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;
  double? selectedPitch;

  void setPitch(double pitch) {
    selectedPitch = pitch;
    notifyListeners();
  }

  void setSelectedMaterial(MaterialModel m) {
    selectedMaterial = m;
    notifyListeners();
  }

  void setWireDiameterUnit(MeasureUnit m) {
    wireDiameterUnit = m;
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

  void clearControllers() {
    wastageController.clear();
    wireDiameterController.clear();
    costPerKgController.clear();
    widthController.clear();
    lengthController.clear();
    notifyListeners();
  }

  Future<void> calculate() async {
    final pitchMm = selectedPitch ?? 0;

    final diameterMm = wireDiameterUnit.toMm(double.tryParse(wireDiameterController.text) ?? 0);

    final widthM = widthUnit.toMm(double.tryParse(widthController.text) ?? 0) / 1000;

    final lengthM = lengthUnit.toMm(double.tryParse(lengthController.text) ?? 0) / 1000;

    final wastage = double.tryParse(wastageController.text) ?? 0;
    final costKg = double.tryParse(costPerKgController.text) ?? 0;

    if (pitchMm <= 0 || diameterMm <= 0 || widthM <= 0 || lengthM <= 0) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
      return;
    }

    final area = widthM * lengthM;

    final factor = (selectedMaterial.materialConstant * pow(diameterMm, 2)) / pitchMm;

    final netWeight = factor * area;

    final totalWithWastage = netWeight * (1 + wastage / 100);

    totalWeight = totalWithWastage;

    totalCost = totalWeight * costKg;

    notifyListeners();
  }
}
