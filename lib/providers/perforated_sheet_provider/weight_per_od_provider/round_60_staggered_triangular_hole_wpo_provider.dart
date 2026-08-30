import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class Round60StaggeredTriangularHoleWpoProvider with ChangeNotifier {
  MaterialModel? selectedMaterial;

  final holeDiameterCtrl = TextEditingController();
  final pitchCtrl = TextEditingController();

  final thicknessCtrl = TextEditingController();
  final outerDiameterCtrl = TextEditingController();
  final perforationDiameterCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  MeasureUnit holeDiameterUnit = MeasureUnit.mm;
  MeasureUnit pitchUnit = MeasureUnit.mm;

  MeasureUnit thicknessUnit = MeasureUnit.mm;
  MeasureUnit outerDiameterUnit = MeasureUnit.mm;
  MeasureUnit perforationDiameterUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  void setSelectedMaterial(MaterialModel material) {
    selectedMaterial = material;
    notifyListeners();
  }

  void setHoleDiameterUnit(MeasureUnit u) { holeDiameterUnit = u; notifyListeners(); }
  void setPitchUnit(MeasureUnit u) { pitchUnit = u; notifyListeners(); }

  void setThicknessUnit(MeasureUnit u) { thicknessUnit = u; notifyListeners(); }
  void setOuterDiameterUnit(MeasureUnit u) { outerDiameterUnit = u; notifyListeners(); }
  void setPerforationDiameterUnit(MeasureUnit u) { perforationDiameterUnit = u; notifyListeners(); }

  void clearControllers() {
    holeDiameterCtrl.clear();
    pitchCtrl.clear();

    thicknessCtrl.clear();
    outerDiameterCtrl.clear();
    perforationDiameterCtrl.clear();
    costCtrl.clear();
    totalWeight = 0;
    totalCost = 0;
    notifyListeners();
  }

  double _toMm(double value, MeasureUnit unit) {
    if (unit == MeasureUnit.cm) return value * 10;
    if (unit == MeasureUnit.inch) return value * 25.4;
    if (unit == MeasureUnit.m) return value * 1000;
    if (unit == MeasureUnit.ft) return value * 304.8;
    return value;
  }

  Future<void> calculate() async {
    if (selectedMaterial == null) return;
    
    final double holeDiameter = double.tryParse(holeDiameterCtrl.text.trim()) ?? 0;
    final double pitch = double.tryParse(pitchCtrl.text.trim()) ?? 0;

    final double thickness = double.tryParse(thicknessCtrl.text.trim()) ?? 0;
    final double od = double.tryParse(outerDiameterCtrl.text.trim()) ?? 0;
    final double pd = double.tryParse(perforationDiameterCtrl.text.trim()) ?? 0;

    double openAreaPercent = 0.0;

    double hd = _toMm(holeDiameter, holeDiameterUnit);
    double p = _toMm(pitch, pitchUnit);
    
    double holeArea = 3.141592653589793 * (hd/2) * (hd/2);
    double pitchArea = p * p * 0.86602540378; // p^2 * sin(60)
    if (pitchArea > 0) {
      openAreaPercent = (holeArea / pitchArea) * 100;
    }
    
    double density = selectedMaterial!.density.toDouble(); // kg/m3

    double odM = _toMm(od, outerDiameterUnit) / 1000.0;
    double pdM = _toMm(pd, perforationDiameterUnit) / 1000.0;
    double tM  = _toMm(thickness, thicknessUnit) / 1000.0;
    
    double totalArea = 3.141592653589793 * (odM / 2) * (odM / 2);
    double perfArea = 3.141592653589793 * (pdM / 2) * (pdM / 2);
    double solidArea = totalArea - perfArea;
    if (solidArea < 0) solidArea = 0; // fallback if perf > sheet

    double solidWeight = solidArea * tM * density;
    double perfWeight = perfArea * tM * density * (1 - (openAreaPercent / 100.0));
    
    totalWeight = solidWeight + perfWeight;
    
    double costPerKg = double.tryParse(costCtrl.text.trim()) ?? 0;
    totalCost = totalWeight * costPerKg;

    notifyListeners();
  }
}
