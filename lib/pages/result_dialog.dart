import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_string.dart';

class ChainLinkResultDialog extends StatelessWidget {
  final double totalWeight;
  final double totalCost;

  const ChainLinkResultDialog({
    super.key,
    required this.totalWeight,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: 5,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade600
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.calculate_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Calculation Result",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),

                const SizedBox(height: 25),

                _resultTile(
                  context,
                  label: AppString.totalWeight,
                  value: "${totalWeight.toStringAsFixed(2)} kg",
                  icon: Icons.monitor_weight_outlined,
                ),

                const SizedBox(height: 14),

                _resultTile(
                  context,
                  label: AppString.totalCost,
                  value: "₹ ${totalCost.toStringAsFixed(2)}",
                  icon: Icons.currency_rupee,
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  child: AppButton().appButton(AppString.ok, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultTile(
      BuildContext context, {
        required String label,
        required String value,
        required IconData icon,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}