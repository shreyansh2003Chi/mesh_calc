import 'package:flutter/material.dart';

class AreaToRunningProvider with ChangeNotifier {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController widthController = TextEditingController();

  final List<String> units = [
    'PRICE PER SQUARE METER',
    'PRICE PER SQUARE FOOT',
    'PRICE PER SQUARE INCH',
  ];

  String selectedUnit = 'PRICE PER SQUARE METER';
  String resultText = '';

  AreaToRunningProvider() {
    priceController.addListener(_calculate);
    widthController.addListener(_calculate);
  }

  void setUnit(String unit) {
    selectedUnit = unit;
    notifyListeners();
    _calculate();
  }

  String get widthLabel {
    switch (selectedUnit) {
      case 'PRICE PER SQUARE METER':
        return 'WIDTH IN METER:';
      case 'PRICE PER SQUARE FOOT':
        return 'WIDTH IN FOOT:';
      case 'PRICE PER SQUARE INCH':
        return 'WIDTH IN INCH:';
      default:
        return 'WIDTH:';
    }
  }

  String get resultLabel {
    switch (selectedUnit) {
      case 'PRICE PER SQUARE METER':
        return 'PRICE PER RUNNING METER:';
      case 'PRICE PER SQUARE FOOT':
        return 'PRICE PER RUNNING FOOT:';
      case 'PRICE PER SQUARE INCH':
        return 'PRICE PER RUNNING INCH:';
      default:
        return 'PRICE PER RUNNING:';
    }
  }

  void _calculate() {
    double price = double.tryParse(priceController.text) ?? 0.0;
    double width = double.tryParse(widthController.text) ?? 0.0;
    
    if (priceController.text.isEmpty || widthController.text.isEmpty) {
      resultText = '';
    } else {
      double result = price * width;
      resultText = _formatValue(result);
    }
    notifyListeners();
  }

  String _formatValue(double value) {
    if (value == 0) return '0';
    if (value == value.toInt()) return value.toInt().toString();
    
    String s = value.toStringAsFixed(2);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0*$'), '');
      if (s.endsWith('.')) {
        s = s.substring(0, s.length - 1);
      }
    }
    return s;
  }

  void clear() {
    priceController.clear();
    widthController.clear();
  }

  @override
  void dispose() {
    priceController.dispose();
    widthController.dispose();
    super.dispose();
  }
}
