import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';

class MaterialSelectionBottomSheetProvider with ChangeNotifier {
  MaterialModel material = MaterialModel(id: 'aluminium', name: 'Aluminium', color: Color(0xFF546E7A), materialConstant: 67, density: 22);
  final List<MaterialModel> materials = [
    MaterialModel(id: 'gi', name: 'Galvanized Iron (GI)', color: Color(0xFF757575), materialConstant: 22.2, density: 7850),
    MaterialModel(id: 'mild_steel', name: 'Mild Steel', color: Color(0xFF424242), materialConstant: 22.2, density: 7850),
    MaterialModel(id: 'steel', name: 'Steel', color: Color(0xFF616161), materialConstant: 22.2, density: 7850),
    MaterialModel(id: 'spring_steel', name: 'Spring Steel', color: Color(0xFF2F2F2F), materialConstant: 22.15, density: 7850),
    MaterialModel(id: 'ss304', name: 'Stainless Steel (304)', color: Color(0xFF607D8B), materialConstant: 22.5, density: 7930),
    MaterialModel(id: 'aluminium', name: 'Aluminium', color: Color(0xFF546E7A), materialConstant: 7.6, density: 2700),
    MaterialModel(id: 'copper', name: 'Copper', color: Color(0xFFB35A2E), materialConstant: 25.3, density: 8960),
    MaterialModel(id: 'brass', name: 'Brass', color: Color(0xFFB8860B), materialConstant: 24.1, density: 8500),
    MaterialModel(id: 'bronze', name: 'Bronze', color: Color(0xFF8D5524), materialConstant: 25.0, density: 8800),
    MaterialModel(id: 'phosphor_bronze', name: 'Phosphor Bronze', color: Color(0xFF7B3F00), materialConstant: 25.1, density: 8850),
    MaterialModel(id: 'cast_iron', name: 'Cast Iron', color: Color(0xFF3E3E3E), materialConstant: 20.4, density: 7200),
    MaterialModel(id: 'nickel', name: 'Nickel', color: Color(0xFF6D6D6D), materialConstant: 25.2, density: 8900),
    MaterialModel(id: 'zinc', name: 'Zinc', color: Color(0xFF757575), materialConstant: 20.2, density: 7140),
    MaterialModel(id: 'titanium', name: 'Titanium', color: Color(0xFF455A64), materialConstant: 12.8, density: 4500),
    MaterialModel(id: 'silver', name: 'Silver', color: Color(0xFF9E9E9E), materialConstant: 29.7, density: 10490),
    MaterialModel(id: 'gold_24k', name: 'Gold (24k)', color: Color(0xFFFFB300), materialConstant: 54.7, density: 19300),
    MaterialModel(id: 'platinum', name: 'Platinum', color: Color(0xFF90A4AE), materialConstant: 60.8, density: 21450),
    MaterialModel(id: 'molybdenum', name: 'Molybdenum', color: Color(0xFF616161), materialConstant: 28.9, density: 10200),
    MaterialModel(id: 'chrome', name: 'Chrome (Chromium)', color: Color(0xFF78909C), materialConstant: 20.4, density: 7190),
    MaterialModel(id: 'nichrome', name: 'Nichrome', color: Color(0xFF5F5F5F), materialConstant: 23.8, density: 8400),
    MaterialModel(id: 'monel', name: 'Monel', color: Color(0xFF6C6C6C), materialConstant: 25.0, density: 8800),
    MaterialModel(id: 'hastelloy', name: 'Hastelloy', color: Color(0xFF555555), materialConstant: 25.3, density: 8900),
    MaterialModel(id: 'inconel', name: 'Inconel', color: Color(0xFF4A4A4A), materialConstant: 24.1, density: 8470),
    MaterialModel(id: 'pvc', name: 'PVC', color: Color(0xFF546E7A), materialConstant: 3.9, density: 1380),
    MaterialModel(id: 'nylon', name: 'Nylon', color: Color(0xFF5C6BC0), materialConstant: 3.2, density: 1150),
    MaterialModel(id: 'hdpe', name: 'Polyethylene (HDPE)', color: Color(0xFF00897B), materialConstant: 2.7, density: 950),
    MaterialModel(id: 'ptfe', name: 'Teflon (PTFE)', color: Color(0xFF455A64), materialConstant: 6.2, density: 2200),
    MaterialModel(id: 'epoxy_resin', name: 'Resin (Epoxy)', color: Color(0xFF1976D2), materialConstant: 3.4, density: 1200),
    MaterialModel(id: 'glass', name: 'Glass', color: Color(0xFF0288D1), materialConstant: 7.1, density: 2500),
    MaterialModel(id: 'bakelite', name: 'Bakelite', color: Color(0xFF5D4037), materialConstant: 3.7, density: 1300),
    MaterialModel(id: 'textolite', name: 'Textolite', color: Color(0xFF4E342E), materialConstant: 4.0, density: 1400),
    MaterialModel(id: 'silicon', name: 'Silicon', color: Color(0xFF546E7A), materialConstant: 6.6, density: 2330),
    MaterialModel(id: 'cement', name: 'Cement (Set)', color: Color(0xFF757575), materialConstant: 8.5, density: 2400),
  ];
  String _searchQuery = "";

  void init() {
    _searchQuery = "";
    notifyListeners();
  }

  void setSearchQuery(String value) {
    _searchQuery = value.toLowerCase();
    notifyListeners();
  }

  List<MaterialModel> get filteredMaterials {
    if (_searchQuery.isEmpty) return materials;

    return materials.where((m) => m.name.toLowerCase().contains(_searchQuery)).toList();
  }

  void setSelectedMaterial(MaterialModel materialModel) {
    material = materialModel;
    notifyListeners();
  }
}
