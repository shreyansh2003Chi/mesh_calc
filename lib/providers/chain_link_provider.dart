import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';

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
  MaterialModel materialModel = MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), kValue: 0.0068);
  final List<MaterialModel> materials = [
    MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), kValue: 0.0068),
    MaterialModel(id: 'br', name: 'Brass', color: Color(0xFFB08D57), kValue: 0.021),
    MaterialModel(id: 'bz', name: 'Bronze', color: Color(0xFF8D6E63), kValue: 0.022),
    MaterialModel(id: 'ci', name: 'Cast Iron', color: Color(0xFF424242), kValue: 0.020),
    MaterialModel(id: 'cu', name: 'Copper', color: Color(0xFFB87333), kValue: 0.023),
    MaterialModel(id: 'gi', name: 'Galvanized Iron', color: Color(0xFF90A4AE), kValue: 0.020),
    MaterialModel(id: 'st', name: 'Steel', color: Color(0xFF607D8B), kValue: 0.020),
  ];

  final Map<String, double> materialK = {'Aluminiu  m': 0.0068, 'Brass': 0.021, 'Bronze': 0.022, 'Cast Iron': 0.020, 'Copper': 0.023, 'Galvanized Iron': 0.020, 'Steel': 0.020};

  final Map<String, Color> materialColors = {
    'Aluminium': const Color(0xFFB0BEC5),
    'Brass': const Color(0xFFB08D57),
    'Bronze': const Color(0xFF8D6E63),
    'Cast Iron': const Color(0xFF424242),
    'Copper': const Color(0xFFB87333),
    'Galvanized Iron': const Color(0xFF90A4AE),
    'Steel': const Color(0xFF607D8B),
  };

  void onMaterialChange(MaterialModel material) {
    materialModel = material;
    notifyListeners();
  }

  Future<void> calculate() async {
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

    final K = materialModel?.kValue ?? 0;
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
