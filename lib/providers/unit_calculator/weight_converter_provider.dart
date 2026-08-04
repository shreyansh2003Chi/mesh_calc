import 'package:flutter/material.dart';

class WeightConverterProvider with ChangeNotifier {
  final TextEditingController topController = TextEditingController();
  final TextEditingController bottomController = TextEditingController();

  final List<String> units = [
    'Pounds (lb)',
    'Kilogram (kg)',
    'Gram (g)',
    'Milligram (mg)',
    'Ounce (o)',
    'Ton (T)',
  ];

  final Map<String, double> _toKgMultiplier = {
    'Pounds (lb)': 0.453592,
    'Kilogram (kg)': 1.0,
    'Gram (g)': 0.001,
    'Milligram (mg)': 0.000001,
    'Ounce (o)': 0.0283495,
    'Ton (T)': 1000.0,
  };

  String topUnit = 'Pounds (lb)';
  String bottomUnit = 'Gram (g)';

  WeightConverterProvider() {
    topController.addListener(_onTopChanged);
    bottomController.addListener(_onBottomChanged);
  }

  bool _isUpdating = false;

  void _onTopChanged() {
    if (_isUpdating) return;
    _isUpdating = true;
    _calculateBottom();
    _isUpdating = false;
  }

  void _onBottomChanged() {
    if (_isUpdating) return;
    _isUpdating = true;
    _calculateTop();
    _isUpdating = false;
  }

  void setTopUnit(String unit) {
    topUnit = unit;
    notifyListeners();
    _isUpdating = true;
    _calculateBottom();
    _isUpdating = false;
  }

  void setBottomUnit(String unit) {
    bottomUnit = unit;
    notifyListeners();
    _isUpdating = true;
    _calculateBottom(); 
    _isUpdating = false;
  }

  void _calculateBottom() {
    if (topController.text.isEmpty) {
      bottomController.text = '';
      return;
    }
    double? topVal = double.tryParse(topController.text);
    if (topVal == null) {
      bottomController.text = '';
      return;
    }

    double kg = topVal * _toKgMultiplier[topUnit]!;
    double bottomVal = kg / _toKgMultiplier[bottomUnit]!;
    bottomController.text = _formatValue(bottomVal);
  }

  void _calculateTop() {
    if (bottomController.text.isEmpty) {
      topController.text = '';
      return;
    }
    double? bottomVal = double.tryParse(bottomController.text);
    if (bottomVal == null) {
      topController.text = '';
      return;
    }

    double kg = bottomVal * _toKgMultiplier[bottomUnit]!;
    double topVal = kg / _toKgMultiplier[topUnit]!;
    topController.text = _formatValue(topVal);
  }

  String _formatValue(double value) {
    if (value == 0) return '0';
    if (value == value.toInt()) return value.toInt().toString();
    
    String s = value.toString();
    if (s.contains('e')) {
      return s; 
    }
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0*$'), '');
      if (s.endsWith('.')) {
        s = s.substring(0, s.length - 1);
      }
    }
    return s;
  }

  void clear() {
    _isUpdating = true;
    topController.clear();
    bottomController.clear();
    _isUpdating = false;
  }

  void swapUnits() {
    _isUpdating = true;
    String tempUnit = topUnit;
    topUnit = bottomUnit;
    bottomUnit = tempUnit;
    
    String tempText = topController.text;
    topController.text = bottomController.text;
    bottomController.text = tempText;
    
    notifyListeners();
    _isUpdating = false;
  }

  @override
  void dispose() {
    topController.dispose();
    bottomController.dispose();
    super.dispose();
  }
}
