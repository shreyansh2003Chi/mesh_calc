import 'dart:math';
import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class WeldedWireMeshProvider with ChangeNotifier {
  final widthCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costCtrl = TextEditingController();
  final widthOpeningCtrl = TextEditingController();
  final wireDiameterWidthCtrl = TextEditingController();
  final wireDiameterLengthCtrl = TextEditingController();
  final lengthOpeningCtrl = TextEditingController();
  double totalWeight = 0;
  double totalCost = 0;

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

  MaterialModel selectedMaterial = MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), materialConstant: 67, density: 2700);

  void clearController() {
    widthCtrl.clear();
    lengthCtrl.clear();
    wastageCtrl.clear();
    costCtrl.clear();
    widthOpeningCtrl.clear();
    wireDiameterWidthCtrl.clear();
    wireDiameterLengthCtrl.clear();
    lengthOpeningCtrl.clear();
  }

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
    final wOpg = widthOpeningUnit.toMm(double.tryParse(widthOpeningCtrl.text) ?? 0) / 1000;
    final wwd = widthDiameterUnit.toMm(double.tryParse(wireDiameterWidthCtrl.text) ?? 0) / 1000;
    final lOpg = lengthOpeningUnit.toMm(double.tryParse(lengthOpeningCtrl.text) ?? 0) / 1000;
    final lwd = lengthDiameterUnit.toMm(double.tryParse(wireDiameterLengthCtrl.text) ?? 0) / 1000;

    final widthM = widthUnit.toMm(double.tryParse(widthCtrl.text) ?? 0) / 1000;
    final lengthM = lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000;

    final wastage = double.tryParse(wastageCtrl.text) ?? 0;
    final costKg = double.tryParse(costCtrl.text) ?? 0;

    double pitch1 = wOpg + wwd;
    double pitch2 = lOpg + lwd;

    if (pitch1 <= 0 || pitch2 <= 0 || widthM <= 0 || lengthM <= 0) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
      return;
    }

    double numWiresWarp = widthM / pitch1;
    double numWiresWeft = lengthM / pitch2;

    double area1 = (pi * pow(wwd, 2)) / 4;
    double totalLengthWarp = numWiresWarp * lengthM;
    double volumeWarp = totalLengthWarp * area1;

    double area2 = (pi * pow(lwd, 2)) / 4;
    double totalLengthWeft = numWiresWeft * widthM;
    double volumeWeft = totalLengthWeft * area2;

    double totalBaseWeight = (volumeWarp + volumeWeft) * selectedMaterial.density;

    double weightWithCrimp = totalBaseWeight * (1 + (2 / 100));

    totalWeight = weightWithCrimp * (1 + (wastage / 100));
    totalCost = totalWeight * costKg;

    notifyListeners();
  }
}
