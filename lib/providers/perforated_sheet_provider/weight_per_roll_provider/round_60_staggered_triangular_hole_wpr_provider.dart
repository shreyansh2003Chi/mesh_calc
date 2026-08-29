import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class Round60StaggeredTriangularHoleWprProvider with ChangeNotifier {
  MaterialModel? selectedMaterial;

  final holeDiameterCtrl = TextEditingController();
  final pitchCtrl = TextEditingController();

  final thicknessCtrl = TextEditingController();
  final sheetWidthCtrl = TextEditingController();
  final sheetLengthCtrl = TextEditingController();
  final perforationWidthCtrl = TextEditingController();
  final perforationLengthCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  MeasureUnit holeDiameterUnit = MeasureUnit.mm;
  MeasureUnit pitchUnit = MeasureUnit.mm;

  MeasureUnit thicknessUnit = MeasureUnit.mm;
  MeasureUnit sheetWidthUnit = MeasureUnit.mm;
  MeasureUnit sheetLengthUnit = MeasureUnit.mm;
  MeasureUnit perforationWidthUnit = MeasureUnit.mm;
  MeasureUnit perforationLengthUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  void setSelectedMaterial(MaterialModel material) {
    selectedMaterial = material;
    notifyListeners();
  }

  void setHoleDiameterUnit(MeasureUnit u) {
    holeDiameterUnit = u;
    notifyListeners();
  }
  void setPitchUnit(MeasureUnit u) {
    pitchUnit = u;
    notifyListeners();
  }

  void setThicknessUnit(MeasureUnit u) {
    thicknessUnit = u;
    notifyListeners();
  }

  void setSheetWidthUnit(MeasureUnit u) {
    sheetWidthUnit = u;
    notifyListeners();
  }

  void setSheetLengthUnit(MeasureUnit u) {
    sheetLengthUnit = u;
    notifyListeners();
  }

  void setPerforationWidthUnit(MeasureUnit u) {
    perforationWidthUnit = u;
    notifyListeners();
  }

  void setPerforationLengthUnit(MeasureUnit u) {
    perforationLengthUnit = u;
    notifyListeners();
  }

  void clearControllers() {
    holeDiameterCtrl.clear();
    pitchCtrl.clear();

    thicknessCtrl.clear();
    sheetWidthCtrl.clear();
    sheetLengthCtrl.clear();
    perforationWidthCtrl.clear();
    perforationLengthCtrl.clear();
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
    final double sheetWidth = double.tryParse(sheetWidthCtrl.text.trim()) ?? 0;
    final double sheetLength = double.tryParse(sheetLengthCtrl.text.trim()) ?? 0;
    final double perforationWidth = double.tryParse(perforationWidthCtrl.text.trim()) ?? 0;
    final double perforationLength = double.tryParse(perforationLengthCtrl.text.trim()) ?? 0;
    double t = thickness;
    double sw = sheetWidth;
    double sl = sheetLength;
    double pw = perforationWidth;
    double pl = perforationLength;

    double openAreaPercent = 0.0;

    double hd = _toMm(holeDiameter, holeDiameterUnit);
    double p = _toMm(pitch, pitchUnit);
    
    double holeArea = 3.141592653589793 * (hd/2) * (hd/2);
    double pitchArea = p * p * 0.86602540378; // p^2 * sin(60)
    if (pitchArea > 0) {
      openAreaPercent = (holeArea / pitchArea) * 100;
    }

    
    double density = selectedMaterial!.density.toDouble(); // kg/m3

    double swM = _toMm(sw, sheetWidthUnit) / 1000.0;
    double slM = _toMm(sl, sheetLengthUnit) / 1000.0;
    double pwM = _toMm(pw, perforationWidthUnit) / 1000.0;
    double plM = _toMm(pl, perforationLengthUnit) / 1000.0;
    double tM  = _toMm(t, thicknessUnit) / 1000.0;
    
    double totalArea = swM * slM;
    double perfArea = pwM * plM;
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
