import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';

class ResultDialog extends StatelessWidget {
  final double totalWeight;
  final double totalCost;

  const ResultDialog({super.key, required this.totalWeight, required this.totalCost});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width > 600 ? 420 : double.infinity),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.96),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(blurRadius: 30, spreadRadius: 0, offset: const Offset(0, 12), color: Colors.black.withOpacity(0.12))],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                          child: Icon(Icons.analytics_outlined, color: AppColors().c1F5F8B, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text("Calculation Result", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
                        ),
                        IconButton(splashRadius: 20, icon: const Icon(Icons.close, size: 25), onPressed: () => Navigator.pop(context)),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: theme.colorScheme.surfaceVariant.withOpacity(0.4)),
                      child: Column(
                        children: [
                          _resultRow(context, AppString.totalWeight, "${totalWeight.toStringAsFixed(2)} kg"),
                          const SizedBox(height: 18),
                          Divider(height: 1, thickness: 0.6, color: Colors.grey.shade300),
                          const SizedBox(height: 18),
                          _resultRow(context, AppString.totalCost, "₹ ${totalCost.toStringAsFixed(2)}"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(width: double.infinity, height: 48, child: AppButton().appButton("Ok", context)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ),
        Text(value, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
