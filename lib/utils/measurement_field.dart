import 'package:flutter/material.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'measurement_unit.dart';

class MeasurementField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  final MeasureUnit? unit;
  final ValueChanged<MeasureUnit>? onUnitChanged;

  final bool showUnit;

  const MeasurementField({
    super.key,
    required this.controller,
    required this.label,
    this.unit,
    this.onUnitChanged,
    this.showUnit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField().textField(controller, label),
        ),

        if (showUnit) ...[
          const SizedBox(width: 10),
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors().cEAEAEA,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<MeasureUnit>(
                value: unit,
                items: MeasureUnit.values.map((u) {
                  return DropdownMenuItem(
                    value: u,
                    child: Text(u.label),
                  );
                }).toList(),
                onChanged: (v) {
                  if (v != null && onUnitChanged != null) {
                    onUnitChanged!(v);
                  }
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}