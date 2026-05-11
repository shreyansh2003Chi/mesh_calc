import 'package:flutter/cupertino.dart';
import 'package:measurements/utils/measurement_unit.dart';

class RectangularStaggeredTriangularHoleProvider with ChangeNotifier {
  final widthHoleCtrl = TextEditingController();
  final lengthHoleCtrl = TextEditingController();
  final widthPitchCtrl = TextEditingController();
  final lengthPitchCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  MeasureUnit widthHoleUnit = MeasureUnit.mm;
  MeasureUnit lengthHoleUnit = MeasureUnit.mm;
  MeasureUnit widthPitchUnit = MeasureUnit.mm;
  MeasureUnit lengthPitchUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  void setWidthHoleUnit(MeasureUnit u) {
    widthHoleUnit = u;
    notifyListeners();
  }

  void setLengthHoleUnit(MeasureUnit u) {
    lengthHoleUnit = u;
    notifyListeners();
  }

  void setWidthPitchUnit(MeasureUnit u) {
    widthPitchUnit = u;
    notifyListeners();
  }

  void setLengthPitchUnit(MeasureUnit u) {
    lengthPitchUnit = u;
    notifyListeners();
  }

  void clearControllers() {}

  Future<void> calculate() async {
    final double widthHole = double.tryParse(widthHoleCtrl.text.trim()) ?? 0;

    final double lengthHole = double.tryParse(lengthHoleCtrl.text.trim()) ?? 0;

    final double widthPitch = double.tryParse(widthPitchCtrl.text.trim()) ?? 0;

    final double lengthPitch = double.tryParse(lengthPitchCtrl.text.trim()) ?? 0;

    if (widthHole <= 0 || lengthHole <= 0 || widthPitch <= 0 || lengthPitch <= 0) {
      totalWeight = 0;
      notifyListeners();
      return;
    }

    double radius = widthHole / 2;

    double holeArea = ((lengthHole - widthHole) * widthHole) + (3.141592653589793 * radius * radius);

    double pitchArea = widthPitch * lengthPitch;

    double openAreaPercent = (holeArea / pitchArea) * 100;

    totalWeight = openAreaPercent;

    notifyListeners();
  }
}
