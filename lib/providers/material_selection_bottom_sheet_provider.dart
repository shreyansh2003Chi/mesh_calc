import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';

class MaterialSelectionBottomSheetProvider with ChangeNotifier {
  MaterialModel material = MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), materialConstant: 67, density: 22);
  final List<MaterialModel> materials = [
    MaterialModel(id: 'gi', name: 'Galvanized Iron (GI)', color: Color(0xFF9E9E9E), materialConstant: 22.2, density: 7850),
    MaterialModel(id: 'mild_steel', name: 'Mild Steel', color: Color(0xFF616161), materialConstant: 22.2, density: 7850),
    MaterialModel(id: 'steel', name: 'Steel', color: Color(0xFF757575), materialConstant: 22.2, density: 7850),
    MaterialModel(id: 'spring_steel', name: 'Spring Steel', color: Color(0xFF5D5D5D), materialConstant: 22.15, density: 7850),
    MaterialModel(id: 'ss304', name: 'Stainless Steel (304)', color: Color(0xFFB0BEC5), materialConstant: 22.5, density: 7930),
    MaterialModel(id: 'aluminium', name: 'Aluminium', color: Color(0xFFCFD8DC), materialConstant: 7.6, density: 2700),
    MaterialModel(id: 'copper', name: 'Copper', color: Color(0xFFB87333), materialConstant: 25.3, density: 8960),
    MaterialModel(id: 'brass', name: 'Brass', color: Color(0xFFCD7F32), materialConstant: 24.1, density: 8500),
    MaterialModel(id: 'bronze', name: 'Bronze', color: Color(0xFF8C6239), materialConstant: 25.0, density: 8800),
    MaterialModel(id: 'phosphor_bronze', name: 'Phosphor Bronze', color: Color(0xFF8B5A2B), materialConstant: 25.1, density: 8850),
    MaterialModel(id: 'cast_iron', name: 'Cast Iron', color: Color(0xFF4E4E4E), materialConstant: 20.4, density: 7200),
    MaterialModel(id: 'nickel', name: 'Nickel', color: Color(0xFF8D8D8D), materialConstant: 25.2, density: 8900),
    MaterialModel(id: 'zinc', name: 'Zinc', color: Color(0xFFBDBDBD), materialConstant: 20.2, density: 7140),
    MaterialModel(id: 'titanium', name: 'Titanium', color: Color(0xFF9E9E9E), materialConstant: 12.8, density: 4500),
    MaterialModel(id: 'silver', name: 'Silver', color: Color(0xFFC0C0C0), materialConstant: 29.7, density: 10490),
    MaterialModel(id: 'gold_24k', name: 'Gold (24k)', color: Color(0xFFFFD700), materialConstant: 54.7, density: 19300),
    MaterialModel(id: 'platinum', name: 'Platinum', color: Color(0xFFE5E4E2), materialConstant: 60.8, density: 21450),
    MaterialModel(id: 'molybdenum', name: 'Molybdenum', color: Color(0xFF9C9C9C), materialConstant: 28.9, density: 10200),
    MaterialModel(id: 'chrome', name: 'Chrome (Chromium)', color: Color(0xFFB0BEC5), materialConstant: 20.4, density: 7190),
    MaterialModel(id: 'nichrome', name: 'Nichrome', color: Color(0xFF7E7E7E), materialConstant: 23.8, density: 8400),
    MaterialModel(id: 'monel', name: 'Monel', color: Color(0xFF8C8C8C), materialConstant: 25.0, density: 8800),
    MaterialModel(id: 'hastelloy', name: 'Hastelloy', color: Color(0xFF7A7A7A), materialConstant: 25.3, density: 8900),
    MaterialModel(id: 'inconel', name: 'Inconel', color: Color(0xFF6E6E6E), materialConstant: 24.1, density: 8470),
    MaterialModel(id: 'pvc', name: 'PVC', color: Color(0xFFE0E0E0), materialConstant: 3.9, density: 1380),
    MaterialModel(id: 'nylon', name: 'Nylon', color: Color(0xFFDADADA), materialConstant: 3.2, density: 1150),
    MaterialModel(id: 'hdpe', name: 'Polyethylene (HDPE)', color: Color(0xFFECEFF1), materialConstant: 2.7, density: 950),
    MaterialModel(id: 'ptfe', name: 'Teflon (PTFE)', color: Color(0xFFFFFFFF), materialConstant: 6.2, density: 2200),
    MaterialModel(id: 'epoxy_resin', name: 'Resin (Epoxy)', color: Color(0xFFE3F2FD), materialConstant: 3.4, density: 1200),
    MaterialModel(id: 'glass', name: 'Glass', color: Color(0xFFBBDEFB), materialConstant: 7.1, density: 2500),
    MaterialModel(id: 'bakelite', name: 'Bakelite', color: Color(0xFF795548), materialConstant: 3.7, density: 1300),
    MaterialModel(id: 'textolite', name: 'Textolite', color: Color(0xFF6D4C41), materialConstant: 4.0, density: 1400),
    MaterialModel(id: 'silicon', name: 'Silicon', color: Color(0xFF90A4AE), materialConstant: 6.6, density: 2330),
    MaterialModel(id: 'cement', name: 'Cement (Set)', color: Color(0xFFBDBDBD), materialConstant: 8.5, density: 2400),
  ];

  void setSelectedMaterial(MaterialModel materialModel) {
    material = materialModel;
    notifyListeners();
  }
}
