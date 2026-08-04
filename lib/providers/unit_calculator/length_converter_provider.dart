import 'package:flutter/material.dart';

class LengthConverterProvider with ChangeNotifier {
  final TextEditingController topController = TextEditingController();
  final TextEditingController bottomController = TextEditingController();

  final List<String> units = [
    'Meter(m)',
    'Centimeter(cm)',
    'Millimeter(mm)',
    'Foot(ft)',
    'Inch(in)',
    'Micron (u)',
    'FtInch',
    'Yard (Y)',
  ];

  final Map<String, double> _toMeterMultiplier = {
    'Meter(m)': 1.0,
    'Centimeter(cm)': 0.01,
    'Millimeter(mm)': 0.001,
    'Foot(ft)': 0.3048,
    'Inch(in)': 0.0254,
    'Micron (u)': 0.000001,
    'FtInch': 0.3048, // Treated as feet due to single decimal input limitation
    'Yard (Y)': 0.9144,
  };

  String topUnit = 'Meter(m)';
  String bottomUnit = 'Millimeter(mm)';

  LengthConverterProvider() {
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

    double meter = topVal * _toMeterMultiplier[topUnit]!;
    double bottomVal = meter / _toMeterMultiplier[bottomUnit]!;
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

    double meter = bottomVal * _toMeterMultiplier[bottomUnit]!;
    double topVal = meter / _toMeterMultiplier[topUnit]!;
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
