import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:measurements/providers/material_selection_bottom_sheet_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:provider/provider.dart';

class ShowResultBottomSheet extends StatefulWidget {
  final double totalCost;
  final double totalWeight;

  const ShowResultBottomSheet({super.key, required this.totalWeight, required this.totalCost});

  @override
  State<ShowResultBottomSheet> createState() => _ShowResultBottomSheetState();
}

class _ShowResultBottomSheetState extends State<ShowResultBottomSheet> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MaterialSelectionBottomSheetProvider>(
      builder: (context, p, child) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(14)),
                          child: Icon(Icons.calculate_outlined, color: Colors.blue.shade700),
                        ),
                        const SizedBox(width: 14),
                        Text("Calculation Result", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),

                    const SizedBox(height: 30),

                    _resultCard(context, label: "Total Weight", value: "${widget.totalWeight.toStringAsFixed(2)} kg", icon: Icons.monitor_weight_outlined),

                    const SizedBox(height: 16),
                    _resultCard(context, label: "Total Cost", value: "₹ ${widget.totalCost.toStringAsFixed(2)}", icon: Icons.currency_rupee, highlight: true),
                    const Spacer(),

                    AppButton().appButton(AppString.ok, context),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _resultCard(BuildContext context, {required String label, required String value, required IconData icon, bool highlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(color: highlight ? Colors.blue.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, color: highlight ? Colors.blue.shade700 : Colors.grey.shade700),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
