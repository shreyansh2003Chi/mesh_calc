import 'dart:math';
import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/measurement_unit.dart';

class DynamicCalculatorPageProvider with ChangeNotifier {
  final openingCtrl = TextEditingController();
  final diameterCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costCtrl = TextEditingController();
  final widthOpeningCtrl = TextEditingController();

  bool openingCtrlIsVisible = false;
  bool diameterCtrlIsVisible = false;
  bool widthCtrlIsVisible = false;
  bool lengthCtrlIsVisible = false;
  bool wastageCtrlIsVisible = false;
  bool costCtrlIsVisible = false;
  bool widthOpeningCtrlIsVisible = false;

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

  void init({required MeshItem meshItem}) {
    switch (meshItem.title) {
      case AppString.chainLink:
        openingCtrlIsVisible = true;
        diameterCtrlIsVisible = true;
        widthCtrlIsVisible = true;
        lengthCtrlIsVisible = true;
        wastageCtrlIsVisible = true;
        costCtrlIsVisible = true;
        widthOpeningCtrlIsVisible = false;
        break;
      case AppString.weightPerRole:
        openingCtrlIsVisible = false;
        diameterCtrlIsVisible = true;
        widthCtrlIsVisible = true;
        lengthCtrlIsVisible = true;
        wastageCtrlIsVisible = true;
        costCtrlIsVisible = true;
        widthOpeningCtrlIsVisible = true;
        break;
    }
    notifyListeners();
  }

  MeasureUnit openingUnit = MeasureUnit.mm;
  MeasureUnit widthOpeningUnit = MeasureUnit.mm;
  MeasureUnit diameterUnit = MeasureUnit.mm;
  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;
  late MaterialModel materialModel;

  void showMaterialBottomSheet(BuildContext context, DynamicCalculatorPageProvider p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return MaterialSelectionBottomSheet();
      },
    );
  }

  DynamicCalculatorPageProvider() {
    materialModel = materials.first;
  }

  String? validateRequired(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  void onMaterialChange(MaterialModel m) {
    materialModel = m;
    notifyListeners();
  }

  void setOpeningUnit(MeasureUnit u) {
    openingUnit = u;
    notifyListeners();
  }

  void setWidthOpeningUnit(MeasureUnit u) {
    widthOpeningUnit = u;
    notifyListeners();
  }

  void setDiameterUnit(MeasureUnit u) {
    diameterUnit = u;
    notifyListeners();
  }

  void setWidthUnit(MeasureUnit u) {
    widthUnit = u;
    notifyListeners();
  }

  void setLengthUnit(MeasureUnit u) {
    lengthUnit = u;
    notifyListeners();
  }

  void onButtonClicked(String t) {
    switch (t) {
      case AppString.chainLink:
        calculateChainLink();
        break;

      case AppString.weightPerRole:
        calculateWeightPerRole();
        break;
    }
  }

  void calculateWeightPerRole() {
    totalWeight = 0;
    totalCost = 0;

    // Width direction
    final widthOpeningMm = widthOpeningUnit.toMm(double.tryParse(widthOpeningCtrl.text) ?? 0);
    final widthWireDiaMm = diameterUnit.toMm(double.tryParse(diameterCtrl.text) ?? 0);

    // Length direction (reuse openingCtrl as length opening)
    final lengthOpeningMm = openingUnit.toMm(double.tryParse(openingCtrl.text) ?? 0);
    final lengthWireDiaMm = diameterUnit.toMm(double.tryParse(diameterCtrl.text) ?? 0);

    final widthMm = widthUnit.toMm(double.tryParse(widthCtrl.text) ?? 0);
    final lengthMm = lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0);

    final wastage = double.tryParse(wastageCtrl.text) ?? 0;
    final costKg = double.tryParse(costCtrl.text) ?? 0;

    if (widthOpeningMm <= 0 || lengthOpeningMm <= 0 || widthWireDiaMm <= 0 || lengthWireDiaMm <= 0 || widthMm <= 0 || lengthMm <= 0) {
      notifyListeners();
      return;
    }

    /// Pitches
    final pitchWidth = widthOpeningMm + widthWireDiaMm;
    final pitchLength = lengthOpeningMm + lengthWireDiaMm;

    /// Wire counts
    final verticalWires = widthMm / pitchWidth;
    final horizontalWires = lengthMm / pitchLength;

    /// Cross-section areas
    final areaWidthWire = pi * pow(widthWireDiaMm, 2) / 4;
    final areaLengthWire = pi * pow(lengthWireDiaMm, 2) / 4;

    /// Total lengths
    final totalVerticalLength = verticalWires * lengthMm;
    final totalHorizontalLength = horizontalWires * widthMm;

    /// Volumes
    final volumeVertical = totalVerticalLength * areaWidthWire;
    final volumeHorizontal = totalHorizontalLength * areaLengthWire;

    /// Density (kg/mm³)
    final density = _materialDensity(materialModel.id);

    final baseWeight = (volumeVertical + volumeHorizontal) * density;

    totalWeight = baseWeight * (1 + wastage / 100);
    totalCost = totalWeight * costKg;

    notifyListeners();
  }

  double _materialDensity(String id) {
    switch (id) {
      case 'al':
        return 0.0000027;
      case 'ss':
        return 0.0000079;
      case 'gi':
      case 'ms':
      case 'st':
        return 0.00000785;
      case 'cu':
        return 0.00000896;
      case 'br':
        return 0.0000084;
      default:
        return 0.00000785;
    }
  }

  void calculate({required MeshItem meshItem}) {
    if (meshItem.title == AppString.chainLink) {
      calculateChainLink();
    } else if (meshItem.title == AppString.weightPerRole) {
      calculateWeightPerRole();
    }
  }

  void calculateChainLink() {
    final openingMm = openingUnit.toMm(double.tryParse(openingCtrl.text) ?? 0);
    final diameterMm = diameterUnit.toMm(double.tryParse(diameterCtrl.text) ?? 0);
    final widthM = widthUnit.toMm(double.tryParse(widthCtrl.text) ?? 0) / 1000;
    final lengthM = lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000;

    final wastage = double.tryParse(wastageCtrl.text) ?? 0;
    final costKg = double.tryParse(costCtrl.text) ?? 0;

    if (openingMm <= 0 || diameterMm <= 0 || widthM <= 0 || lengthM <= 0) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
      return;
    }

    final area = widthM * lengthM;

    final factor = (materialModel.kValue * pow(diameterMm, 2)) / (openingMm + diameterMm);

    final netWeight = factor * area;
    final totalWithWastage = netWeight * (1 + wastage / 100);

    totalWeight = totalWithWastage;
    totalCost = totalWeight * costKg;

    notifyListeners();
  }

  @override
  void dispose() {
    openingCtrl.dispose();
    diameterCtrl.dispose();
    widthCtrl.dispose();
    lengthCtrl.dispose();
    wastageCtrl.dispose();
    costCtrl.dispose();
    super.dispose();
  }
}
