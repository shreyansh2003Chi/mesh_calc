import 'package:flutter/animation.dart';

class MaterialModel {
  final String id;
  final String name;
  final Color color;
  final double materialConstant;
  final int density;

  MaterialModel({required this.id, required this.name, required this.color, required this.materialConstant, required this.density});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MaterialModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
