import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class RectangleWireProvider with ChangeNotifier {
  final widthThicknessCtrl = TextEditingController();
  final lengthThicknessCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  double totalWeight = 0;
  double totalCost = 0;

  MeasureUnit widthThicknessUnit = MeasureUnit.mm;
  MeasureUnit lengthThicknessUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  MaterialModel selectedMaterial = MaterialModel(
    id: 'al',
    name: 'Aluminium',
    color: const Color(0xFFB0BEC5),
    materialConstant: 67,
    density: 2700,
  );

  void clearController() {
    widthThicknessCtrl.clear();
    lengthThicknessCtrl.clear();
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

  void setWidthThicknessUnit(MeasureUnit unit) {
    widthThicknessUnit = unit;
    notifyListeners();
  }

  void setLengthThicknessUnit(MeasureUnit unit) {
    lengthThicknessUnit = unit;
    notifyListeners();
  }

  void setLengthUnit(MeasureUnit unit) {
    lengthUnit = unit;
    notifyListeners();
  }

  void calculate() {
    final double widthThickness = widthThicknessUnit.toMm(double.tryParse(widthThicknessCtrl.text) ?? 0) / 1000.0;
    final double lengthThickness = lengthThicknessUnit.toMm(double.tryParse(lengthThicknessCtrl.text) ?? 0) / 1000.0;
    final double length = lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000.0;
    final double costKg = double.tryParse(costCtrl.text.trim()) ?? 0;

    if (widthThickness <= 0 || lengthThickness <= 0 || length <= 0) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
      return;
    }

    // Area of Rectangle
    final double area = widthThickness * lengthThickness;
    
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
    widthThicknessCtrl.dispose();
    lengthThicknessCtrl.dispose();
    lengthCtrl.dispose();
    costCtrl.dispose();
    super.dispose();
  }
}
