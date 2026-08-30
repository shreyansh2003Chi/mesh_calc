import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class RectangularStaggeredTriangularHoleWpoProvider with ChangeNotifier {
  MaterialModel? selectedMaterial;

  final widthHoleCtrl = TextEditingController();
  final lengthHoleCtrl = TextEditingController();
  final widthPitchCtrl = TextEditingController();
  final lengthPitchCtrl = TextEditingController();
  final thicknessCtrl = TextEditingController();
  final outerDiameterCtrl = TextEditingController();
  final perforationDiameterCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  MeasureUnit widthHoleUnit = MeasureUnit.mm;
  MeasureUnit lengthHoleUnit = MeasureUnit.mm;
  MeasureUnit widthPitchUnit = MeasureUnit.mm;
  MeasureUnit lengthPitchUnit = MeasureUnit.mm;
  MeasureUnit thicknessUnit = MeasureUnit.mm;
  MeasureUnit outerDiameterUnit = MeasureUnit.mm;
  MeasureUnit perforationDiameterUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  void setSelectedMaterial(MaterialModel material) {
    selectedMaterial = material;
    notifyListeners();
  }

  void setWidthHoleUnit(MeasureUnit u) { widthHoleUnit = u; notifyListeners(); }
  void setLengthHoleUnit(MeasureUnit u) { lengthHoleUnit = u; notifyListeners(); }
  void setWidthPitchUnit(MeasureUnit u) { widthPitchUnit = u; notifyListeners(); }
  void setLengthPitchUnit(MeasureUnit u) { lengthPitchUnit = u; notifyListeners(); }
  void setThicknessUnit(MeasureUnit u) { thicknessUnit = u; notifyListeners(); }
  void setOuterDiameterUnit(MeasureUnit u) { outerDiameterUnit = u; notifyListeners(); }
  void setPerforationDiameterUnit(MeasureUnit u) { perforationDiameterUnit = u; notifyListeners(); }

  void clearControllers() {
    widthHoleCtrl.clear();
    lengthHoleCtrl.clear();
    widthPitchCtrl.clear();
    lengthPitchCtrl.clear();
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
    
    final double widthHole = double.tryParse(widthHoleCtrl.text.trim()) ?? 0;
    final double lengthHole = double.tryParse(lengthHoleCtrl.text.trim()) ?? 0;
    final double widthPitch = double.tryParse(widthPitchCtrl.text.trim()) ?? 0;
    final double lengthPitch = double.tryParse(lengthPitchCtrl.text.trim()) ?? 0;
    final double thickness = double.tryParse(thicknessCtrl.text.trim()) ?? 0;
    final double od = double.tryParse(outerDiameterCtrl.text.trim()) ?? 0;
    final double pd = double.tryParse(perforationDiameterCtrl.text.trim()) ?? 0;
    
    double openAreaPercent = 0.0;

    double wh = _toMm(widthHole, widthHoleUnit);
    double lh = _toMm(lengthHole, lengthHoleUnit);
    double wp = _toMm(widthPitch, widthPitchUnit);
    double lp = _toMm(lengthPitch, lengthPitchUnit);
    
    double holeArea = wh * lh;
    double pitchArea = wp * lp;
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
