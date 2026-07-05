import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:measurements/providers/wire_mesh/wire_required_provider.dart';
import 'package:provider/provider.dart';

class WireRequired extends StatefulWidget {
  const WireRequired({super.key});

  @override
  State<WireRequired> createState() => _WireRequiredState();
}

class _WireRequiredState extends State<WireRequired> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WireRequiredProvider>(context, listen: false).clearController();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cFaFaFa,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors().c1F5F8B,
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
        title: const Text(
          "Wires Required",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        child: Consumer<WireRequiredProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Image.asset(AppAssets.weightPerRollWiremesh, height: 200),
                const SizedBox(height: 20),

                MeasurementField(controller: p.widthOpeningCtrl, label: AppString.widthOpeningWopgMm, unit: p.widthOpeningUnit, onUnitChanged: p.setWidthOpeningUnit),
                const SizedBox(height: 16),
                MeasurementField(controller: p.wireDiameterWidthCtrl, label: AppString.wireDiameter, unit: p.widthDiameterUnit, onUnitChanged: p.setWidthDiameterUnit),

                const SizedBox(height: 16),
                MeasurementField(controller: p.lengthOpeningCtrl, label: AppString.lengthOpeningLOPG, unit: p.lengthOpeningUnit, onUnitChanged: p.setLengthOpeningUnit),
                const SizedBox(height: 16),
                MeasurementField(controller: p.wireDiameterLengthCtrl, label: AppString.wireDiameter, unit: p.lengthDiameterUnit, onUnitChanged: p.setLengthDiameterUnit),

                const SizedBox(height: 16),
                MeasurementField(controller: p.widthCtrl, label: AppString.widthW, unit: p.widthUnit, onUnitChanged: p.setWidthUnit),
                const SizedBox(height: 16),
                MeasurementField(controller: p.lengthCtrl, label: AppString.lengthL, unit: p.lengthUnit, onUnitChanged: p.setLengthUnit),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: GestureDetector(
                    onTap: () {
                      p.calculate().then((_) {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => _WiresRequiredDialog(
                            numberOfLineWires: p.numberOfLineWires,
                            numberOfCrossWires: p.numberOfCrossWires,
                          ),
                        );
                      });
                    },
                    child: AppButton().appButton(AppString.calculate, context),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _WiresRequiredDialog extends StatelessWidget {
  final int numberOfLineWires;
  final int numberOfCrossWires;

  const _WiresRequiredDialog({
    required this.numberOfLineWires,
    required this.numberOfCrossWires,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;
    
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 20, vertical: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(isSmall ? 16 : 24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(.96),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(blurRadius: 30, offset: const Offset(0, 12), color: Colors.black.withOpacity(.12)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        height: isSmall ? 38 : 44,
                        width: isSmall ? 38 : 44,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.analytics_outlined, size: isSmall ? 18 : 22, color: AppColors().c1F5F8B),
                      ),
                      SizedBox(width: isSmall ? 10 : 14),
                      Expanded(
                        child: Text(
                          AppString.result,
                          style: TextStyle(fontSize: isSmall ? 17 : 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(Icons.close, size: isSmall ? 18 : 22),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmall ? 18 : 24),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant.withOpacity(.35),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        _resultRow(context, "Line Wires", "$numberOfLineWires", isSmall ? 12 : 16),
                        Divider(height: 1, thickness: .6, color: Colors.grey.shade300),
                        _resultRow(context, "Cross Wires", "$numberOfCrossWires", isSmall ? 12 : 16),
                        Divider(height: 1, thickness: .6, color: Colors.grey.shade300),
                        _resultRow(context, "Total Wires", "${numberOfLineWires + numberOfCrossWires}", isSmall ? 12 : 16, isHighlight: true),
                      ],
                    ),
                  ),
                  SizedBox(height: isSmall ? 20 : 28),
                  SizedBox(
                    width: double.infinity,
                    height: isSmall ? 46 : 52,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: AppButton().appButton(AppString.ok, context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: isHighlight ? FontWeight.w600 : FontWeight.w500,
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
