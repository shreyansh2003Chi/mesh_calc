import 'dart:math';
import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/utils/measurement_unit.dart';

class WeightPerOdWwProvider with ChangeNotifier {
  final widthOpeningCtrl = TextEditingController();
  final wireDiameterWidthCtrl = TextEditingController();
  final lengthOpeningCtrl = TextEditingController();
  final wireDiameterLengthCtrl = TextEditingController();
  final outerDiameterCtrl = TextEditingController();
  final wastageCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  double totalWeight = 0;
  double totalCost = 0;
  double weightWithoutWastage = 0;
  double weightWithWastage = 0;

  MeasureUnit widthOpeningUnit = MeasureUnit.mm;
  MeasureUnit widthDiameterUnit = MeasureUnit.mm;
  MeasureUnit lengthOpeningUnit = MeasureUnit.mm;
  MeasureUnit lengthDiameterUnit = MeasureUnit.mm;
  MeasureUnit outerDiameterUnit = MeasureUnit.mm;

  MaterialModel selectedMaterial = MaterialModel(
    id: 'al',
    name: 'Aluminium',
    color: const Color(0xFFB0BEC5),
    materialConstant: 67,
    density: 2700,
  );

  void clearController() {
    widthOpeningCtrl.clear();
    wireDiameterWidthCtrl.clear();
    lengthOpeningCtrl.clear();
    wireDiameterLengthCtrl.clear();
    outerDiameterCtrl.clear();
    wastageCtrl.clear();
    costCtrl.clear();

    totalWeight = 0;
    totalCost = 0;
    weightWithoutWastage = 0;
    weightWithWastage = 0;
    notifyListeners();
  }

  void setSelectedMaterial(MaterialModel material) {
    selectedMaterial = material;
    notifyListeners();
  }

  void setWidthOpeningUnit(MeasureUnit unit) { widthOpeningUnit = unit; notifyListeners(); }
  void setWidthDiameterUnit(MeasureUnit unit) { widthDiameterUnit = unit; notifyListeners(); }
  void setLengthOpeningUnit(MeasureUnit unit) { lengthOpeningUnit = unit; notifyListeners(); }
  void setLengthDiameterUnit(MeasureUnit unit) { lengthDiameterUnit = unit; notifyListeners(); }
  void setOuterDiameterUnit(MeasureUnit unit) { outerDiameterUnit = unit; notifyListeners(); }

  void calculate() {
    final double wOpg = widthOpeningUnit.toMm(double.tryParse(widthOpeningCtrl.text) ?? 0) / 1000;
    final double wwd = widthDiameterUnit.toMm(double.tryParse(wireDiameterWidthCtrl.text) ?? 0) / 1000;
    final double lOpg = lengthOpeningUnit.toMm(double.tryParse(lengthOpeningCtrl.text) ?? 0) / 1000;
    final double lwd = lengthDiameterUnit.toMm(double.tryParse(wireDiameterLengthCtrl.text) ?? 0) / 1000;
    final double od = outerDiameterUnit.toMm(double.tryParse(outerDiameterCtrl.text) ?? 0) / 1000;
    final double wastage = double.tryParse(wastageCtrl.text.trim()) ?? 0;
    final double costKg = double.tryParse(costCtrl.text.trim()) ?? 0;

    final double pitchWidth = wOpg + wwd;
    final double pitchLength = lOpg + lwd;

    if (pitchWidth <= 0 || pitchLength <= 0 || od <= 0) {
      totalWeight = 0;
      totalCost = 0;
      weightWithoutWastage = 0;
      weightWithWastage = 0;
      notifyListeners();
      return;
    }

    // Calculate weight per square meter
    final double widthM = 1.0;
    final double lengthM = 1.0;
    
    final int numberOfLineWires = (widthM / pitchWidth).ceil() + 1;
    final int numberOfCrossWires = (lengthM / pitchLength).ceil() + 1;

    final double widthWireArea = (pi * pow(wwd, 2)) / 4;
    final double totalWidthWireLength = numberOfLineWires * lengthM;
    final double widthWireVolume = totalWidthWireLength * widthWireArea;

    final double lengthWireArea = (pi * pow(lwd, 2)) / 4;
    final double totalLengthWireLength = numberOfCrossWires * widthM;
    final double lengthWireVolume = totalLengthWireLength * lengthWireArea;

    final double totalVolumePerM2 = widthWireVolume + lengthWireVolume;
    final double weightPerM2 = totalVolumePerM2 * selectedMaterial.density;

    // Calculate area of OD
    final double areaOfMesh = (pi * pow(od, 2)) / 4;

    weightWithoutWastage = weightPerM2 * areaOfMesh;
    weightWithWastage = weightWithoutWastage * (1 + (wastage / 100));

    totalWeight = weightWithWastage;
    totalCost = totalWeight * costKg;

    notifyListeners();
  }

  @override
  void dispose() {
    widthOpeningCtrl.dispose();
    wireDiameterWidthCtrl.dispose();
    lengthOpeningCtrl.dispose();
    wireDiameterLengthCtrl.dispose();
    outerDiameterCtrl.dispose();
    wastageCtrl.dispose();
    costCtrl.dispose();
    super.dispose();
  }
}
