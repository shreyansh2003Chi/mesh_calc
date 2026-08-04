import 'package:flutter/material.dart';

class AreaConverterProvider with ChangeNotifier {
  final TextEditingController topController = TextEditingController();
  final TextEditingController bottomController = TextEditingController();

  final List<String> units = [
    'Square-Kilometer (sqkm)',
    'Square-Feet (sqft)',
    'Square-Inch (sqin)',
    'Square-Meter (sqm)',
    'Square-Centimeter (sqcm)',
    'Square-Millimeter (sqmm)',
    'Acres (ac)',
    'Square-Yards (sqy)',
  ];

  final Map<String, double> _toSqmMultiplier = {
    'Square-Kilometer (sqkm)': 1000000.0,
    'Square-Feet (sqft)': 0.092903,
    'Square-Inch (sqin)': 0.00064516,
    'Square-Meter (sqm)': 1.0,
    'Square-Centimeter (sqcm)': 0.0001,
    'Square-Millimeter (sqmm)': 0.000001,
    'Acres (ac)': 4046.86,
    'Square-Yards (sqy)': 0.836127,
  };

  String topUnit = 'Square-Feet (sqft)';
  String bottomUnit = 'Square-Kilometer (sqkm)';

  AreaConverterProvider() {
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
    _calculateBottom(); // or calculateTop depending on preference, usually top drives bottom on unit change
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

    double sqm = topVal * _toSqmMultiplier[topUnit]!;
    double bottomVal = sqm / _toSqmMultiplier[bottomUnit]!;
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

    double sqm = bottomVal * _toSqmMultiplier[bottomUnit]!;
    double topVal = sqm / _toSqmMultiplier[topUnit]!;
    topController.text = _formatValue(topVal);
  }

  String _formatValue(double value) {
    if (value == 0) return '0';
    if (value == value.toInt()) return value.toInt().toString();
    
    // Convert to string and handle exponential notation if necessary
    String s = value.toString();
    if (s.contains('e')) {
      return s; // Keep scientific notation for very large/small numbers
    }
    // Remove trailing zeros
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
