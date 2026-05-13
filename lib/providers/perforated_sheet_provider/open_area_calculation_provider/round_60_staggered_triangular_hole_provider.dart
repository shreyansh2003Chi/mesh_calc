import 'package:flutter/cupertino.dart';
import 'package:measurements/utils/measurement_unit.dart';

class Round60StaggeredTriangularHoleProvider with ChangeNotifier {
  final holeDiameterCtrl = TextEditingController();
  final pitchCtrl = TextEditingController();

  double totalWeight = 0;
  double totalCost = 0;
  MeasureUnit holeDiameterUnit = MeasureUnit.mm;
  MeasureUnit pitchUnit = MeasureUnit.mm;

  void setPitchUnit(MeasureUnit u) {
    pitchUnit = u;
    notifyListeners();
  }

  void setHoleDiameterUnit(MeasureUnit u) {
    holeDiameterUnit = u;
    notifyListeners();
  }

  void clearControllers() {}

  Future<void> calculate() async {}
}
