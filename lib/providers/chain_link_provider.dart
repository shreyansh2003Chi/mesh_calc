import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';

class ChainLinkProvider extends ChangeNotifier {
  final openingCtrl = TextEditingController();
  final wireCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costCtrl = TextEditingController();
  final openInMeasCtr = TextEditingController();
  final wireMeasCtr = TextEditingController();
  final widthMeasCtrl = TextEditingController();
  final lengthMeasCtrl = TextEditingController();
  final wastageMeasCtrl = TextEditingController();
  final costMeasCtrl = TextEditingController();

  String material = 'Cast Iron';
  double totalWeight = 0;
  double totalCost = 0;
  late MaterialModel materialModel;

  ChainLinkProvider() {
    materialModel = materials.first;
  }

  final List<MaterialModel> materials = [
    MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), kValue: 0.0068),
    MaterialModel(id: 'br', name: 'Brass', color: Color(0xFFB08D57), kValue: 0.021),
    MaterialModel(id: 'bz', name: 'Bronze', color: Color(0xFF8D6E63), kValue: 0.022),
    MaterialModel(id: 'ci', name: 'Cast Iron', color: Color(0xFF424242), kValue: 0.020),
    MaterialModel(id: 'cu', name: 'Copper', color: Color(0xFFB87333), kValue: 0.023),
    MaterialModel(id: 'gi', name: 'Galvanized Iron', color: Color(0xFF90A4AE), kValue: 0.020),
    MaterialModel(id: 'st', name: 'Steel', color: Color(0xFF607D8B), kValue: 0.020),
    MaterialModel(id: 'ss', name: 'Stainless Steel', color: Color(0xFFB0BEC5), kValue: 0.017),
    MaterialModel(id: 'ms', name: 'Mild Steel', color: Color(0xFF78909C), kValue: 0.020),
    MaterialModel(id: 'fe', name: 'Iron', color: Color(0xFF616161), kValue: 0.021),
    MaterialModel(id: 'zn', name: 'Zinc', color: Color(0xFFBDBDBD), kValue: 0.016),
    MaterialModel(id: 'ti', name: 'Titanium', color: Color(0xFF9E9E9E), kValue: 0.0086),
    MaterialModel(id: 'ni', name: 'Nickel', color: Color(0xFF757575), kValue: 0.022),
  ];

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

    final K = materialModel.kValue;
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
