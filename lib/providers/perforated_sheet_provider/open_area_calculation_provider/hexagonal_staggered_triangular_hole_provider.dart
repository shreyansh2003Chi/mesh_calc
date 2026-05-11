import 'package:flutter/cupertino.dart';
import 'package:measurements/utils/measurement_unit.dart';

class HexagonalStaggeredTriangularHoleProvider with ChangeNotifier {
  final hexagonalHoleCtrl = TextEditingController();
  final pitchCtrl = TextEditingController();

  double totalWeight = 0;
  double totalCost = 0;
  MeasureUnit hexagonalHoleUnit = MeasureUnit.mm;
  MeasureUnit pitchUnit = MeasureUnit.mm;

  void setPitchUnit(MeasureUnit u) {
    pitchUnit = u;
    notifyListeners();
  }

  void setHexagonalHoleCtrl(MeasureUnit u) {
    hexagonalHoleUnit = u;
    notifyListeners();
  }

  void clearControllers() {}

  Future<void> calculate() async {}
}
