import 'package:flutter/material.dart';

class AreaToAreaProvider with ChangeNotifier {
  final TextEditingController topController = TextEditingController();
  final TextEditingController bottomController = TextEditingController();

  final List<String> units = [
    'Price per square Meter',
    'Price per square Foot',
    'Price per square Inch',
    'Price per circle',
  ];

  // How many of [Unit] fit in 1 Square Meter.
  // E.g., 1 SqM = 10.7639 SqFt. 
  // If price is $1 per SqFt, price per SqM is 1 * 10.7639.
  final Map<String, double> _toPricePerSqMMultiplier = {
    'Price per square Meter': 1.0,
    'Price per square Foot': 10.76391,
    'Price per square Inch': 1550.0031,
    'Price per circle': 1.0, // Placeholder until user clarifies
  };

  String topUnit = 'Price per square Meter';
  String bottomUnit = 'Price per square Inch';

  AreaToAreaProvider() {
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

    double pricePerSqM = topVal * _toPricePerSqMMultiplier[topUnit]!;
    double bottomVal = pricePerSqM / _toPricePerSqMMultiplier[bottomUnit]!;
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

    double pricePerSqM = bottomVal * _toPricePerSqMMultiplier[bottomUnit]!;
    double topVal = pricePerSqM / _toPricePerSqMMultiplier[topUnit]!;
    topController.text = _formatValue(topVal);
  }

  String _formatValue(double value) {
    if (value == 0) return '0';
    if (value == value.toInt()) return value.toInt().toString();
    
    String s = value.toStringAsFixed(4);
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
