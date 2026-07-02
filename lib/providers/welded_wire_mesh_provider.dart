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

  double areaOfWireMesh = 0;
  double numberOfCrossWires = 0;
  double numberOfLineWires = 0;
  double weightWithoutWastage = 0;
  double weightWithWastage = 0;

  String selectedCrimp = "NO CRIMP";
  double selectedCrimpPercentage = 0;

  final List<String> crimpList = [
    "NO CRIMP",
    "2% CRIMP",
    "5% CRIMP",
    "9% CRIMP",
  ];

  MeasureUnit widthOpeningUnit = MeasureUnit.mm;
  MeasureUnit lengthOpeningUnit = MeasureUnit.mm;
  MeasureUnit diameterUnit = MeasureUnit.mm;
  MeasureUnit widthUnit = MeasureUnit.mm;
  MeasureUnit lengthUnit = MeasureUnit.mm;
  MeasureUnit widthDiameterUnit = MeasureUnit.mm;
  MeasureUnit lengthDiameterUnit = MeasureUnit.mm;

  MaterialModel selectedMaterial = MaterialModel(
    id: 'al',
    name: 'Aluminium',
    color: const Color(0xFFB0BEC5),
    materialConstant: 67,
    density: 2700,
  );

  void clearController() {
    widthCtrl.clear();
    lengthCtrl.clear();
    wastageCtrl.clear();
    costCtrl.clear();
    widthOpeningCtrl.clear();
    wireDiameterWidthCtrl.clear();
    wireDiameterLengthCtrl.clear();
    lengthOpeningCtrl.clear();

    totalWeight = 0;
    totalCost = 0;

    areaOfWireMesh = 0;
    numberOfCrossWires = 0;
    numberOfLineWires = 0;
    weightWithoutWastage = 0;
    weightWithWastage = 0;

    selectedCrimp = "NO CRIMP";
    selectedCrimpPercentage = 0;

    notifyListeners();
  }

  void setSelectedMaterial(MaterialModel material) {
    selectedMaterial = material;
    notifyListeners();
  }

  void setWidthOpeningUnit(MeasureUnit unit) {
    widthOpeningUnit = unit;
    notifyListeners();
  }

  void setWidthDiameterUnit(MeasureUnit unit) {
    widthDiameterUnit = unit;
    notifyListeners();
  }

  void setLengthOpeningUnit(MeasureUnit unit) {
    lengthOpeningUnit = unit;
    notifyListeners();
  }

  void setLengthDiameterUnit(MeasureUnit unit) {
    lengthDiameterUnit = unit;
    notifyListeners();
  }

  void setWidthUnit(MeasureUnit unit) {
    widthUnit = unit;
    notifyListeners();
  }

  void setLengthUnit(MeasureUnit unit) {
    lengthUnit = unit;
    notifyListeners();
  }

  void setSelectedCrimpPercentage(String? value) {
    if (value == null) return;

    selectedCrimp = value;

    switch (value) {
      case "NO CRIMP":
        selectedCrimpPercentage = 0;
        break;
      case "2% CRIMP":
        selectedCrimpPercentage = 2;
        break;
      case "5% CRIMP":
        selectedCrimpPercentage = 5;
        break;
      case "9% CRIMP":
        selectedCrimpPercentage = 9;
        break;
      default:
        selectedCrimpPercentage = 0;
    }

    notifyListeners();
  }

  void calculate() {
    final double wOpg =
        widthOpeningUnit.toMm(double.tryParse(widthOpeningCtrl.text) ?? 0) /
            1000;

    final double wwd =
        widthDiameterUnit
            .toMm(double.tryParse(wireDiameterWidthCtrl.text) ?? 0) /
            1000;

    final double lOpg =
        lengthOpeningUnit.toMm(double.tryParse(lengthOpeningCtrl.text) ?? 0) /
            1000;

    final double lwd =
        lengthDiameterUnit
            .toMm(double.tryParse(wireDiameterLengthCtrl.text) ?? 0) /
            1000;

    final double widthM =
        widthUnit.toMm(double.tryParse(widthCtrl.text) ?? 0) / 1000;

    final double lengthM =
        lengthUnit.toMm(double.tryParse(lengthCtrl.text) ?? 0) / 1000;

    final double wastage =
        double.tryParse(wastageCtrl.text.trim()) ?? 0;

    final double costKg =
        double.tryParse(costCtrl.text.trim()) ?? 0;

    final double pitchWidth = wOpg + wwd;
    final double pitchLength = lOpg + lwd;

    if (pitchWidth <= 0 ||
        pitchLength <= 0 ||
        widthM <= 0 ||
        lengthM <= 0) {
      totalWeight = 0;
      totalCost = 0;
      areaOfWireMesh = 0;
      numberOfCrossWires = 0;
      numberOfLineWires = 0;
      weightWithoutWastage = 0;
      weightWithWastage = 0;
      notifyListeners();
      return;
    }

    areaOfWireMesh = widthM * lengthM;

    // Number of wires
    numberOfLineWires = (widthM / pitchWidth).ceil() + 1;
    numberOfCrossWires = (lengthM / pitchLength).ceil() + 1;

    // Width wire calculations
    final double widthWireArea = (pi * pow(wwd, 2)) / 4;
    final double totalWidthWireLength = numberOfLineWires * lengthM;
    final double widthWireVolume =
        totalWidthWireLength * widthWireArea;

    // Length wire calculations
    final double lengthWireArea = (pi * pow(lwd, 2)) / 4;
    final double totalLengthWireLength = numberOfCrossWires * widthM;
    final double lengthWireVolume =
        totalLengthWireLength * lengthWireArea;

    // Total volume
    final double totalVolume =
        widthWireVolume + lengthWireVolume;

    // Base weight in KG
    final double baseWeight =
        totalVolume * selectedMaterial.density;

    // Apply selected crimp percentage
    weightWithoutWastage =
        baseWeight *
            (1 + (selectedCrimpPercentage / 100));

    // Apply wastage percentage
    weightWithWastage =
        weightWithoutWastage *
            (1 + (wastage / 100));

    totalWeight = weightWithWastage;
    // Cost
    totalCost = totalWeight * costKg;

    notifyListeners();
  }

  @override
  void dispose() {
    widthCtrl.dispose();
    lengthCtrl.dispose();
    wastageCtrl.dispose();
    costCtrl.dispose();
    widthOpeningCtrl.dispose();
    wireDiameterWidthCtrl.dispose();
    wireDiameterLengthCtrl.dispose();
    lengthOpeningCtrl.dispose();
    super.dispose();
  }
}