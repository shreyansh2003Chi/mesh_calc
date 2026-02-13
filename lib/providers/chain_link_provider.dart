import 'dart:math';
import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class ChainLinkProvider extends ChangeNotifier {
  final openingCtrl = TextEditingController();
  final diameterCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  MeasureUnit openingUnit = MeasureUnit.mm;
  MeasureUnit diameterUnit = MeasureUnit.mm;
  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  MaterialModel selectedMaterial = MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), kValue: 67);

  void setSelectedMaterial(MaterialModel m) {
    selectedMaterial = m;
    notifyListeners();
  }

  void setOpeningUnit(MeasureUnit u) {
    openingUnit = u;
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

  void calculate() {
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

    final factor = (selectedMaterial.kValue * pow(diameterMm, 2)) / (openingMm + diameterMm);

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
