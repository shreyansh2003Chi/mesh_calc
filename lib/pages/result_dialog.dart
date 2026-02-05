import 'package:flutter/material.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';

class ChainLinkResultDialog extends StatelessWidget {
  final double totalWeight;
  final double totalCost;

  const ChainLinkResultDialog({super.key, required this.totalWeight, required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calculate_outlined, size: 26),
                      const SizedBox(width: 10),
                      Text(
                        "Calculation Result",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, size: 25),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _resultTile(
                context,
                label: AppString.totalWeight,
                value: "${totalWeight.toStringAsFixed(2)} kg",
                icon: Icons.monitor_weight_outlined,
              ),

              const SizedBox(height: 12),

              _resultTile(
                context,
                label: AppString.totalCost,
                value: "₹ ${totalCost.toStringAsFixed(2)}",
                icon: Icons.currency_rupee,
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors().c5B2C2C,
                        foregroundColor: AppColors().cFFFFFF,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("OK"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultTile(BuildContext context, {required String label, required String value, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.12), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
