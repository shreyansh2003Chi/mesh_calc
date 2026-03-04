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
    wireDiameterController.clear();
    costPerKgController.clear();
    widthController.clear();
    lengthController.clear();
    notifyListeners();
  }

  Future<void> calculate() async {}
}
