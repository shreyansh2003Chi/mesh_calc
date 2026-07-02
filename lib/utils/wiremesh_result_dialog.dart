import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';

class WiremeshResultDialog extends StatelessWidget {
  final double areaOfWireMesh;
  final double numberOfCrossWires;
  final double numberOfLineWires;
  final double weightWithoutWastage;
  final double weightWithWastage;
  final double totalWeight;
  final double totalCost;

  const WiremeshResultDialog({
    super.key,
    required this.areaOfWireMesh,
    required this.numberOfCrossWires,
    required this.numberOfLineWires,
    required this.weightWithoutWastage,
    required this.weightWithWastage,
    required this.totalWeight,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final bool isSmall = size.width < 360;
    final bool isTablet = size.width >= 600;

    final double dialogWidth = isTablet ? 460 : size.width * .92;
    final double padding = isSmall ? 16 : 24;
    final double iconSize = isSmall ? 18 : 22;
    final double titleSize = isSmall ? 17 : 20;
    final double rowPadding = isSmall ? 12 : 16;
    final double buttonHeight = isSmall ? 46 : 52;

    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 20, vertical: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: dialogWidth),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(.96),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(blurRadius: 30, offset: const Offset(0, 12), color: Colors.black.withOpacity(.12)),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //---------------- HEADER ----------------//
                      Row(
                        children: [
                          Container(
                            height: isSmall ? 38 : 44,
                            width: isSmall ? 38 : 44,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.analytics_outlined, size: iconSize, color: AppColors().c1F5F8B),
                          ),

                          SizedBox(width: isSmall ? 10 : 14),

                          Expanded(
                            child: Text(
                              AppString.result,
                              style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w700),
                            ),
                          ),

                          IconButton(
                            splashRadius: 20,
                            icon: Icon(Icons.close, size: iconSize),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),

                      SizedBox(height: isSmall ? 18 : 24),

                      //---------------- RESULT CARD ----------------//
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant.withOpacity(.35),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            _resultRow(
                              context,
                              "Area of Wire Mesh",
                              "${areaOfWireMesh.toStringAsFixed(2)} m²",
                              rowPadding,
                            ),
                            _divider(),

                            _resultRow(
                              context,
                              "Number of Cross Wires",
                              numberOfCrossWires.toInt().toString(),
                              rowPadding,
                            ),
                            _divider(),

                            _resultRow(
                              context,
                              "Number of Line Wires",
                              numberOfLineWires.toInt().toString(),
                              rowPadding,
                            ),
                            _divider(),

                            _resultRow(
                              context,
                              "Weight Without Wastage",
                              "${weightWithoutWastage.toStringAsFixed(2)} kg",
                              rowPadding,
                            ),
                            _divider(),

                            _resultRow(
                              context,
                              "Weight With Wastage",
                              "${weightWithWastage.toStringAsFixed(2)} kg",
                              rowPadding,
                            ),
                            _divider(),

                            _resultRow(
                              context,
                              AppString.totalWeight,
                              "${totalWeight.toStringAsFixed(2)} kg",
                              rowPadding,
                              isHighlight: true,
                            ),
                            _divider(),

                            _resultRow(
                              context,
                              AppString.totalCost,
                              "₹ ${totalCost.toStringAsFixed(2)}",
                              rowPadding,
                              isHighlight: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: isSmall ? 20 : 28),

                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: AppButton().appButton("OK", context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, thickness: .6, color: Colors.grey.shade300);
  }

  Widget _resultRow(BuildContext context, String label, String value, double padding, {bool isHighlight = false}) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding * .9),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isHighlight ? FontWeight.w600 : FontWeight.w500,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isHighlight ? AppColors().c1F5F8B : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
