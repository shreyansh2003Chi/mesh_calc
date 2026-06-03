import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class WeightPerRollProvider with ChangeNotifier{
  final widthMeshCtrl = TextEditingController();
  final wireDiameterOneCtrl = TextEditingController();
  final lengthMeshCtrl = TextEditingController();
  final wireDiameterTwoCtrl = TextEditingController();
  final widthCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costPerKgCtrl = TextEditingController();

  MeasureUnit wireDiameterOneUnit = MeasureUnit.mm;
  MeasureUnit wireDiameterTwoUnit = MeasureUnit.mm;
  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  MaterialModel selectedMaterial = MaterialModel(id: 'al', name: 'Aluminium', color: Color(0xFFB0BEC5), materialConstant: 67, density: 2700);

  void clearControllers() {

    widthMeshCtrl.clear();
    wireDiameterOneCtrl.clear();
    lengthMeshCtrl.clear();
    wireDiameterTwoCtrl.clear();
    widthCtrl.clear();
    lengthCtrl.clear();
    wastageCtrl.clear();
    costPerKgCtrl.clear();

    totalWeight = 0;
    totalCost = 0;

    notifyListeners();
  }

  void setSelectedMaterial(MaterialModel m) {
    selectedMaterial = m;
    notifyListeners();
  }



  void setWireDiameterOneUnit(MeasureUnit u) {
    wireDiameterOneUnit = u;
    notifyListeners();
  }
  void setWireDiameterTwoUnit(MeasureUnit u) {
    wireDiameterTwoUnit = u;
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

  Future<void> calculate() async {
    try {
      // Mesh openings
      final wm = double.tryParse(widthMeshCtrl.text) ?? 0;
      final lm = double.tryParse(lengthMeshCtrl.text) ?? 0;

      // Wire diameters (convert to mm)
      final wd1Mm = wireDiameterOneUnit.toMm(
        double.tryParse(wireDiameterOneCtrl.text) ?? 0,
      );

      final wd2Mm = wireDiameterTwoUnit.toMm(
        double.tryParse(wireDiameterTwoCtrl.text) ?? 0,
      );

      // Roll dimensions (convert to meters)
      final widthM =
          widthUnit.toMm(double.tryParse(widthCtrl.text) ?? 0) / 1000;

      final lengthM =
          lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000;

      final wastage = double.tryParse(wastageCtrl.text) ?? 0;
      final costPerKg = double.tryParse(costPerKgCtrl.text) ?? 0;

      if (wm <= 0 ||
          lm <= 0 ||
          wd1Mm <= 0 ||
          wd2Mm <= 0 ||
          widthM <= 0 ||
          lengthM <= 0) {
        totalWeight = 0;
        totalCost = 0;
        notifyListeners();
        return;
      }

      // Convert mm → meter
      final wmM = wm / 1000;
      final lmM = lm / 1000;

      final wd1M = wd1Mm / 1000;
      final wd2M = wd2Mm / 1000;

      // Number of wires
      final verticalWires = widthM / (wmM + wd1M);
      final horizontalWires = lengthM / (lmM + wd2M);

      // Cross-sectional areas
      final area1 = pi * pow(wd1M, 2) / 4;
      final area2 = pi * pow(wd2M, 2) / 4;

      // Volume of all vertical wires
      final verticalVolume =
          verticalWires * lengthM * area1;

      // Volume of all horizontal wires
      final horizontalVolume =
          horizontalWires * widthM * area2;

      // Total wire volume (m³)
      final totalVolume =
          verticalVolume + horizontalVolume;

      // Density (kg/m³)
      final density = selectedMaterial.density;

      // Net weight
      final netWeight = totalVolume * density;

      // Add wastage
      totalWeight =
          netWeight * (1 + (wastage / 100));

      // Cost
      totalCost = totalWeight * costPerKg;

      notifyListeners();
    } catch (e) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
    }
  }
}