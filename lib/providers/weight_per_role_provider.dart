import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class WeightPerRoleProvider with ChangeNotifier {
  final widthCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  final widthOpeningCtrl = TextEditingController();
  final wireDiameterWidthCtrl = TextEditingController();
  final wireDiameterLengthCtrl = TextEditingController();
  final lengthOpeningCtrl = TextEditingController();

  String? selectedCrimp;
  double? selectedCrimpPercentage = 0;

  List<String>? crimpList = ["NO CRIMP", "2% CRIMP", "5% CRIMP", "9% CRIMP"];

  MeasureUnit widthOpeningUnit = MeasureUnit.mm;
  MeasureUnit lengthOpeningUnit = MeasureUnit.mm;
  MeasureUnit diameterUnit = MeasureUnit.mm;

  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  MeasureUnit widthDiameterUnit = MeasureUnit.mm;
  MeasureUnit lengthDiameterUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;
  MaterialModel selectedMaterial = MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), kValue: 67);

  void setSelectedMaterial(MaterialModel m) {
    selectedMaterial = m;
    notifyListeners();
  }

  void setWidthOpeningUnit(MeasureUnit u) {
    widthOpeningUnit = u;
    notifyListeners();
  }

  void setWidthDiameterUnit(MeasureUnit u) {
    widthDiameterUnit = u;
    notifyListeners();
  }

  void setLengthOpeningUnit(MeasureUnit u) {
    lengthOpeningUnit = u;
    notifyListeners();
  }

  void setLengthDiameterUnit(MeasureUnit u) {
    lengthDiameterUnit = u;
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

  void setSelectedCrimpPercentage(String? s) {
    selectedCrimp = s;
    notifyListeners();
  }

  void calculate() {
    final wOpg = widthOpeningUnit.toMm(double.tryParse(widthOpeningCtrl.text) ?? 0);
    final wwd = widthDiameterUnit.toMm(double.tryParse(wireDiameterWidthCtrl.text) ?? 0);
    final lOpg = lengthOpeningUnit.toMm(double.tryParse(lengthOpeningCtrl.text) ?? 0);
    final lwd = lengthDiameterUnit.toMm(double.tryParse(wireDiameterLengthCtrl.text) ?? 0);
    final widthM = widthUnit.toMm(double.tryParse(widthCtrl.text) ?? 0) / 1000;
    final lengthM = lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000;
    final wastage = double.tryParse(wastageCtrl.text) ?? 0;
    final costKg = double.tryParse(costCtrl.text) ?? 0;

    double horizontalPitch = wOpg + wwd;
    double verticalPitch = lOpg + lwd;

    double numWiresAcrossWidth = widthM / horizontalPitch;
    double numWiresAcrossLength = lengthM / verticalPitch;

    double totalStraightLength = (numWiresAcrossWidth * lengthM) + (numWiresAcrossLength * widthM);

    // double area = (pi * pow(wd, 2)) / 4;
    //double baseWeight = totalStraightLength * area * density;

    // 5. Apply Crimp and Wastage
    //double weightWithCrimp = baseWeight * (1 + ((selectedCrimp??0) / 100));
    //double finalGrossWeight = weightWithCrimp * (1 + (wastage / 100));

    // 6. Calculate Total Cost
    //double totalCost = finalGrossWeight * costKg;
    totalWeight = 0;
    totalCost = 0;
  }

  @override
  void dispose() {
    widthCtrl.dispose();
    lengthCtrl.dispose();
    wastageCtrl.dispose();
    costCtrl.dispose();
    super.dispose();
  }
}
