import 'package:flutter/cupertino.dart';
import 'package:measurements/utils/measurement_unit.dart';

class Round90CenterToCenterHoleProvider with ChangeNotifier {
  final holeDiameterCtrl = TextEditingController();
  final widthPitchCtrl = TextEditingController();
  final lengthPitchCtrl = TextEditingController();

  double totalWeight = 0;
  double totalCost = 0;
  MeasureUnit holeDiameterUnit = MeasureUnit.mm;
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

  void setHoleDiameterUnit(MeasureUnit u) {
    holeDiameterUnit = u;
    notifyListeners();
  }

  void clearControllers() {}

  Future<void> calculate() async {}
}
