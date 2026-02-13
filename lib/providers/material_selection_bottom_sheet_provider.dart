import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';

class MaterialSelectionBottomSheetProvider with ChangeNotifier {
  MaterialModel material = MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), kValue: 67);
  final List<MaterialModel> materials = [
    MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), kValue: 67),
    MaterialModel(id: 'br', name: 'Brass', color: Color(0xFFB08D57), kValue: 0.021),
    MaterialModel(id: 'bz', name: 'Bronze', color: Color(0xFF8D6E63), kValue: 0.022),
    MaterialModel(id: 'ci', name: 'Cast Iron', color: Color(0xFF424242), kValue: 0.020),
    MaterialModel(id: 'cu', name: 'Copper', color: Color(0xFFB87333), kValue: 0.023),
    MaterialModel(id: 'gi', name: 'Galvanized Iron', color: Color(0xFF90A4AE), kValue: 22.2),
    MaterialModel(id: 'ms', name: 'Mild Steel', color: Color(0xFF78909C), kValue: 0.020),
    MaterialModel(id: 'ss', name: 'Stainless Steel', color: Color(0xFFB0BEC5), kValue: 0.017),
    MaterialModel(id: 'st', name: 'Steel', color: Color(0xFF607D8B), kValue: 0.020),
    MaterialModel(id: 'sp', name: 'Spring Steel', color: Color(0xFF455A64), kValue: 0.021),
    MaterialModel(id: 'ni', name: 'Nickel', color: Color(0xFF757575), kValue: 0.022),
    MaterialModel(id: 'zn', name: 'Zinc', color: Color(0xFFBDBDBD), kValue: 0.016),
    MaterialModel(id: 'ti', name: 'Titanium', color: Color(0xFF9E9E9E), kValue: 0.0086),
    MaterialModel(id: 'ag', name: 'Silver', color: Color(0xFFE0E0E0), kValue: 0.025),
    MaterialModel(id: 'au', name: 'Gold', color: Color(0xFFFFD700), kValue: 0.030),
    MaterialModel(id: 'pt', name: 'Platinum', color: Color(0xFFCFD8DC), kValue: 0.032),
    MaterialModel(id: 'mo', name: 'Molybdenum', color: Color(0xFF6D4C41), kValue: 0.024),
    MaterialModel(id: 'mn', name: 'Magnesium', color: Color(0xFFBDBDBD), kValue: 0.0040),
    MaterialModel(id: 'cr', name: 'Chrome', color: Color(0xFF9E9E9E), kValue: 0.018),
    MaterialModel(id: 'nc', name: 'Nichrome', color: Color(0xFF8D6E63), kValue: 0.019),
    MaterialModel(id: 'mb', name: 'Monel', color: Color(0xFFBCAAA4), kValue: 0.022),
    MaterialModel(id: 'pb', name: 'Phosphor Bronze', color: Color(0xFF795548), kValue: 0.022),
    MaterialModel(id: 'hz', name: 'Hastelloy', color: Color(0xFF616161), kValue: 0.023),
    MaterialModel(id: 'ic', name: 'Inconel', color: Color(0xFF5D4037), kValue: 0.024),

    MaterialModel(id: 'ny', name: 'Nylon', color: Color(0xFF64B5F6), kValue: 0.0012),
    MaterialModel(id: 'pe', name: 'Polyethylene', color: Color(0xFF81C784), kValue: 0.0009),
    MaterialModel(id: 'pv', name: 'PVC', color: Color(0xFF4DB6AC), kValue: 0.0014),
    MaterialModel(id: 'tf', name: 'Teflon', color: Color(0xFFB2EBF2), kValue: 0.0010),
    MaterialModel(id: 'rs', name: 'Resin', color: Color(0xFFCE93D8), kValue: 0.0013),

    MaterialModel(id: 'gl', name: 'Glass', color: Color(0xFF90CAF9), kValue: 0.0025),
    MaterialModel(id: 'bk', name: 'Bakelite', color: Color(0xFF5D4037), kValue: 0.0018),
    MaterialModel(id: 'tx', name: 'Textolite', color: Color(0xFF8BC34A), kValue: 0.0017),
    MaterialModel(id: 'si', name: 'Silicon', color: Color(0xFFB0BEC5), kValue: 0.0023),
    MaterialModel(id: 'cm', name: 'Cement', color: Color(0xFFBDBDBD), kValue: 0.0020),
  ];

  void setSelectedMaterial(MaterialModel materialModel) {
    material = materialModel;
    notifyListeners();
  }


}
