import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class WeightPerOdLessIdProvider with ChangeNotifier {
  final widthMeshCtrl = TextEditingController();
  final wireDiameterOneCtrl = TextEditingController();
  final lengthMeshCtrl = TextEditingController();
  final wireDiameterTwoCtrl = TextEditingController();
  final outerDiameterCtrl = TextEditingController();
  final innerDiameterCtrl = TextEditingController();

  final wastageCtrl = TextEditingController();
  final costPerKgCtrl = TextEditingController();

  MeasureUnit wireDiameterOneUnit = MeasureUnit.mm;
  MeasureUnit wireDiameterTwoUnit = MeasureUnit.mm;
  MeasureUnit outerDiameterUnit = MeasureUnit.mm;
  MeasureUnit innerDiameterUnit = MeasureUnit.mm;

  double totalWeight = 0;
  double totalCost = 0;

  MaterialModel selectedMaterial = MaterialModel(
    id: 'al',
    name: 'Aluminium',
    color: Color(0xFFB0BEC5),
    materialConstant: 67,
    density: 2700,
  );

  void clearControllers() {
    widthMeshCtrl.clear();
    wireDiameterOneCtrl.clear();
    lengthMeshCtrl.clear();
    wireDiameterTwoCtrl.clear();

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

  void setOuterDiameterUnit(MeasureUnit u) {
    outerDiameterUnit = u;
    notifyListeners();
  }

  void setInnerDiameterUnit(MeasureUnit u) {
    innerDiameterUnit = u;
    notifyListeners();
  }

  void setWireDiameterTwoUnit(MeasureUnit u) {
    wireDiameterTwoUnit = u;
    notifyListeners();
  }

  Future<void> calculate() async {
    final widthMeshMm =
        double.tryParse(widthMeshCtrl.text.trim()) ?? 0;

    final lengthMeshMm =
        double.tryParse(lengthMeshCtrl.text.trim()) ?? 0;

    final wireDia1Mm = wireDiameterOneUnit.toMm(
      double.tryParse(wireDiameterOneCtrl.text.trim()) ?? 0,
    );

    final wireDia2Mm = wireDiameterTwoUnit.toMm(
      double.tryParse(wireDiameterTwoCtrl.text.trim()) ?? 0,
    );

    final outerDiameterMm = outerDiameterUnit.toMm(
      double.tryParse(outerDiameterCtrl.text.trim()) ?? 0,
    );

    final innerDiameterMm = innerDiameterUnit.toMm(
      double.tryParse(innerDiameterCtrl.text.trim()) ?? 0,
    );

    final wastage =
        double.tryParse(wastageCtrl.text.trim()) ?? 0;

    final costPerKg =
        double.tryParse(costPerKgCtrl.text.trim()) ?? 0;

    if (widthMeshMm <= 0 ||
        lengthMeshMm <= 0 ||
        wireDia1Mm <= 0 ||
        wireDia2Mm <= 0 ||
        outerDiameterMm <= 0 ||
        innerDiameterMm < 0 ||
        innerDiameterMm >= outerDiameterMm) {
      totalWeight = 0;
      totalCost = 0;
      notifyListeners();
      return;
    }

    final factor1 =
        (selectedMaterial.materialConstant *
            wireDia1Mm *
            wireDia1Mm) /
            (widthMeshMm + wireDia1Mm);

    final factor2 =
        (selectedMaterial.materialConstant *
            wireDia2Mm *
            wireDia2Mm) /
            (lengthMeshMm + wireDia2Mm);

    final meshFactor = factor1 + factor2;

    final rollFactor =
        ((outerDiameterMm * outerDiameterMm) -
            (innerDiameterMm * innerDiameterMm)) /
            100000.0;

    double weight = meshFactor * rollFactor;

    weight *= (1 + wastage / 100);

    totalWeight =
        double.parse(weight.toStringAsFixed(3));

    totalCost =
        double.parse((totalWeight * costPerKg)
            .toStringAsFixed(2));

    notifyListeners();
  }}
