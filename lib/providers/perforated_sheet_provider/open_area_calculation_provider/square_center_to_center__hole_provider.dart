import 'package:flutter/cupertino.dart';
import 'package:measurements/utils/measurement_unit.dart';

class SquareCenterToCenterHoleProvider with ChangeNotifier {
  final squareHoleCtrl = TextEditingController();
  final widthPitchCtrl = TextEditingController();
  final lengthPitchCtrl = TextEditingController();

  double totalWeight = 0;
  double totalCost = 0;
  MeasureUnit squareHoleUnit = MeasureUnit.mm;
  MeasureUnit widthPitchUnit = MeasureUnit.mm;
  MeasureUnit lengthPitchUnit = MeasureUnit.mm;

  void setLengthPitchUnit(MeasureUnit u) {
    lengthPitchUnit = u;
    notifyListeners();
  }

  void setWidthPitchUnit(MeasureUnit u) {
    widthPitchUnit = u;
    notifyListeners();
  }

  void setSquareHoleUnit(MeasureUnit u) {
    squareHoleUnit = u;
    notifyListeners();
  }

  void clearControllers() {}

  Future<void> calculate() async {}
}
