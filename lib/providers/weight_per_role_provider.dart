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
  final wireDiameterForWidth = TextEditingController();
  final wireDiameterForLength = TextEditingController();
  final lengthOpeningCtrl = TextEditingController();

  final List<MaterialModel> materials = [
    MaterialModel(id: 'gi', name: 'Galvanized Iron (GI)', color: Color(0xFF90A4AE), kValue: 22.2),
    MaterialModel(id: 'ms', name: 'Mild Steel', color: Color(0xFF78909C), kValue: 22.2),
    MaterialModel(id: 'st', name: 'Steel', color: Color(0xFF607D8B), kValue: 22.2),
    MaterialModel(id: 'sspr', name: 'Spring Steel', color: Color(0xFF546E7A), kValue: 22.15),
    MaterialModel(id: 'ss', name: 'Stainless Steel', color: Color(0xFFB0BEC5), kValue: 22.5),

    MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFCFD8DC), kValue: 7.6),
    MaterialModel(id: 'cu', name: 'Copper', color: Color(0xFFB87333), kValue: 25.3),
    MaterialModel(id: 'br', name: 'Brass', color: Color(0xFFD4AF37), kValue: 24.1),
    MaterialModel(id: 'bz', name: 'Bronze', color: Color(0xFFCD7F32), kValue: 25.0),
    MaterialModel(id: 'pb', name: 'Phosphor Bronze', color: Color(0xFFB08D57), kValue: 25.1),

    MaterialModel(id: 'ci', name: 'Cast Iron', color: Color(0xFF424242), kValue: 20.4),
    MaterialModel(id: 'ni', name: 'Nickel', color: Color(0xFF9E9E9E), kValue: 25.2),
    MaterialModel(id: 'zn', name: 'Zinc', color: Color(0xFFBDBDBD), kValue: 20.2),
    MaterialModel(id: 'ti', name: 'Titanium', color: Color(0xFF90CAF9), kValue: 12.8),

    MaterialModel(id: 'ag', name: 'Silver', color: Color(0xFFE0E0E0), kValue: 29.7),
    MaterialModel(id: 'au', name: 'Gold', color: Color(0xFFFFD54F), kValue: 54.7),
    MaterialModel(id: 'pt', name: 'Platinum', color: Color(0xFFECEFF1), kValue: 60.8),

    MaterialModel(id: 'mo', name: 'Molybdenum', color: Color(0xFFB0BEC5), kValue: 28.9),
    MaterialModel(id: 'cr', name: 'Chrome', color: Color(0xFF9FA8DA), kValue: 20.4),
    MaterialModel(id: 'nc', name: 'Nichrome', color: Color(0xFF8D6E63), kValue: 23.8),
    MaterialModel(id: 'mn', name: 'Monel', color: Color(0xFFBCAAA4), kValue: 25.0),
    MaterialModel(id: 'hs', name: 'Hastelloy', color: Color(0xFFA1887F), kValue: 25.3),
    MaterialModel(id: 'in', name: 'Inconel', color: Color(0xFF8D8D8D), kValue: 24.1),

    MaterialModel(id: 'pvc', name: 'PVC', color: Color(0xFF81C784), kValue: 3.9),
    MaterialModel(id: 'ny', name: 'Nylon', color: Color(0xFFA5D6A7), kValue: 3.2),
    MaterialModel(id: 'pe', name: 'Polyethylene', color: Color(0xFFC5E1A5), kValue: 2.7),
    MaterialModel(id: 'tf', name: 'Teflon', color: Color(0xFFE8F5E9), kValue: 6.2),
    MaterialModel(id: 'rs', name: 'Resin', color: Color(0xFFB2DFDB), kValue: 3.4),

    MaterialModel(id: 'gl', name: 'Glass', color: Color(0xFFB3E5FC), kValue: 7.1),
    MaterialModel(id: 'bk', name: 'Bakelite', color: Color(0xFF6D4C41), kValue: 3.7),
    MaterialModel(id: 'tx', name: 'Textolite', color: Color(0xFF795548), kValue: 4.0),

    MaterialModel(id: 'si', name: 'Silicon', color: Color(0xFFB0BEC5), kValue: 6.6),
    MaterialModel(id: 'cm', name: 'Cement', color: Color(0xFF9E9E9E), kValue: 8.5),
  ];

  void init(MeshItem meshItem) {
    openingCtrl.clear();
    diameterCtrl.clear();
    widthOpeningCtrl.clear();
    lengthOpeningCtrl.clear();
    wireDiameterForWidth.clear();
    wireDiameterForLength.clear();
    widthCtrl.clear();
    lengthCtrl.clear();
    wastageCtrl.clear();
    costCtrl.clear();

    openingUnit = MeasureUnit.mm;
    diameterUnit = MeasureUnit.mm;

    widthOpeningUnit = MeasureUnit.mm;
    lengthOpeningUnit = MeasureUnit.mm;

    wireDiameterForWidthUnit = MeasureUnit.mm;
    wireDiameterForLengthUnit = MeasureUnit.mm;

    widthUnit = MeasureUnit.mm;
    lengthUnit = MeasureUnit.mm;

    materialModel = materials.first;

    totalWeight = 0;
    totalCost = 0;

    notifyListeners();
  }

  MeasureUnit openingUnit = MeasureUnit.mm;
  MeasureUnit widthOpeningUnit = MeasureUnit.mm;
  MeasureUnit lengthOpeningUnit = MeasureUnit.mm;
  MeasureUnit diameterUnit = MeasureUnit.mm;
  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;
  MeasureUnit wireDiameterForWidthUnit = MeasureUnit.mm;
  MeasureUnit wireDiameterForLengthUnit = MeasureUnit.mm;

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

  void setWireDiameterWidthUnit(MeasureUnit u) {
    wireDiameterForWidthUnit = u;
    notifyListeners();
  }

  void setWireLengthOpeningUnit(MeasureUnit u) {
    lengthOpeningUnit = u;
    notifyListeners();
  }

  void setWireDiameterLengthUnit(MeasureUnit u) {
    wireDiameterForLengthUnit = u;
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



  void calculate({required MeshItem meshItem}) {
    if (meshItem.title == AppString.chainLink) {
      calculateChainLink();
    } else if (meshItem.title == AppString.weightPerRole) {
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
