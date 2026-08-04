import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class OctagonalWireProvider with ChangeNotifier {
  final thicknessCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  double totalWeight = 0;
  double totalCost = 0;

  MeasureUnit thicknessUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  MaterialModel selectedMaterial = MaterialModel(
    id: 'al',
    name: 'Aluminium',
    color: const Color(0xFFB0BEC5),
    materialConstant: 67,
    density: 2700,
  );

  void clearController() {
    thicknessCtrl.clear();
    lengthCtrl.clear();
    costCtrl.clear();
    totalWeight = 0;
    totalCost = 0;
    notifyListeners();
  }

  void setSelectedMaterial(MaterialModel material) {
    selectedMaterial = material;
    notifyListeners();
  }

  void setThicknessUnit(MeasureUnit unit) {
    thicknessUnit = unit;
    notifyListeners();
  }

  void setLengthUnit(MeasureUnit unit) {
    lengthUnit = unit;
    notifyListeners();
  }

  void calculate() {
    final double thickness = thicknessUnit.toMm(double.tryParse(thicknessCtrl.text) ?? 0) / 1000.0;
    final double length = lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000.0;
    final double costKg = double.tryParse(costCtrl.text.trim()) ?? 0;

    if (thickness <= 0 || length <= 0) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
      return;
    }

    // Area of Octagon given width across flats (WT)
    // Area = 0.82842712474 * WT^2
    final double area = 0.82842712474 * (thickness * thickness);
    
    // Volume in m^3
    final double volume = area * length;
    
    // Base weight in KG
    totalWeight = volume * selectedMaterial.density;
    
    // Cost
    totalCost = totalWeight * costKg;

    notifyListeners();
  }

  @override
  void dispose() {
    thicknessCtrl.dispose();
    lengthCtrl.dispose();
    costCtrl.dispose();
    super.dispose();
  }
}
