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

  double areaOfWireMesh = 0;
  double numberOfCrossWires = 0;
  double numberOfLineWires = 0;
  double weightWithoutWastage = 0;
  double weightWithWastage = 0;

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

    areaOfWireMesh = 0;
    numberOfCrossWires = 0;
    numberOfLineWires = 0;
    weightWithoutWastage = 0;
    weightWithWastage = 0;

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
      //==========================
      // Read Inputs
      //==========================

      final wm = double.tryParse(widthMeshCtrl.text) ?? 0; // Mesh Opening Width (mm)
      final lm = double.tryParse(lengthMeshCtrl.text) ?? 0; // Mesh Opening Length (mm)

      final wd1Mm = wireDiameterOneUnit.toMm(
        double.tryParse(wireDiameterOneCtrl.text) ?? 0,
      );

      final wd2Mm = wireDiameterTwoUnit.toMm(
        double.tryParse(wireDiameterTwoCtrl.text) ?? 0,
      );

      final widthM =
          widthUnit.toMm(double.tryParse(widthCtrl.text) ?? 0) / 1000;

      final lengthM =
          lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000;

      final wastage = double.tryParse(wastageCtrl.text) ?? 0;
      final costPerKg = double.tryParse(costPerKgCtrl.text) ?? 0;

      //==========================
      // Validation
      //==========================

      if (wm <= 0 ||
          lm <= 0 ||
          wd1Mm <= 0 ||
          wd2Mm <= 0 ||
          widthM <= 0 ||
          lengthM <= 0) {
        areaOfWireMesh = 0;
        numberOfCrossWires = 0;
        numberOfLineWires = 0;
        weightWithoutWastage = 0;
        weightWithWastage = 0;
        totalWeight = 0;
        totalCost = 0;

        notifyListeners();
        return;
      }

      //==========================
      // Unit Conversion
      //==========================

      final wmM = wm / 1000;
      final lmM = lm / 1000;

      final wd1M = wd1Mm / 1000;
      final wd2M = wd2Mm / 1000;

      //==========================
      // 1. Area of Mesh
      //==========================

      areaOfWireMesh = widthM * lengthM;

      //==========================
      // 2. Number of Wires
      //==========================

      numberOfLineWires =
          (widthM / (wmM + wd1M)).ceil() + 1;

      numberOfCrossWires =
          (lengthM / (lmM + wd2M)).ceil() + 1;

      //==========================
      // 3. Cross Section Area
      //==========================

      final area1 = pi * pow(wd1M, 2) / 4;
      final area2 = pi * pow(wd2M, 2) / 4;

      //==========================
      // 4. Volume
      //==========================

      final verticalVolume =
          numberOfLineWires * lengthM * area1;

      final horizontalVolume =
          numberOfCrossWires * widthM * area2;

      final totalVolume =
          verticalVolume + horizontalVolume;

      //==========================
      // 5. Weight
      //==========================

      weightWithoutWastage =
          totalVolume * selectedMaterial.density;

      weightWithWastage =
          weightWithoutWastage * (1 + wastage / 100);

      //==========================
      // 6. Final Result
      //==========================

      totalWeight = weightWithWastage;
      totalCost = totalWeight * costPerKg;

      notifyListeners();
    } catch (e) {
      areaOfWireMesh = 0;
      numberOfCrossWires = 0;
      numberOfLineWires = 0;
      weightWithoutWastage = 0;
      weightWithWastage = 0;
      totalWeight = 0;
      totalCost = 0;

      notifyListeners();
    }
  }}