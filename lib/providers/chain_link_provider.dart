import 'package:flutter/material.dart';

class ChainLinkProvider extends ChangeNotifier {
  final openingCtrl = TextEditingController();
  final wireCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  String material = 'Cast Iron';

  double totalWeight = 0;
  double totalCost = 0;

  final Map<String, double> materialK = {'Aluminium': 0.0068, 'Brass': 0.021, 'Bronze': 0.022, 'Cast Iron': 0.020, 'Copper': 0.023, 'Galvanized Iron': 0.020, 'Steel': 0.020};

  void calculate() {
    final opening = double.tryParse(openingCtrl.text) ?? 0;
    final wire = double.tryParse(wireCtrl.text) ?? 0;
    final widthMm = double.tryParse(widthCtrl.text) ?? 0;
    final lengthMm = double.tryParse(lengthCtrl.text) ?? 0;
    final wastage = double.tryParse(wastageCtrl.text) ?? 0;
    final costKg = double.tryParse(costCtrl.text) ?? 0;

    if (opening == 0 || wire == 0 || widthMm == 0 || lengthMm == 0) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
      return;
    }

    final K = materialK[material]!;

    final widthM = widthMm / 1000;
    final lengthM = lengthMm / 1000;

    totalWeight = ((wire * wire) / (opening + wire)) * K * widthM * lengthM * 100 * (1 + wastage / 100);

    totalCost = totalWeight * costKg;

    notifyListeners();
  }

  @override
  void dispose() {
    openingCtrl.dispose();
    wireCtrl.dispose();
    widthCtrl.dispose();
    lengthCtrl.dispose();
    wastageCtrl.dispose();
    costCtrl.dispose();
    super.dispose();
  }
}
