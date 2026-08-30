import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/providers/welded_wiremesh_provided/wires_required_ww_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class WiresRequiredWw extends StatefulWidget {
  final MeshItem meshItem;

  const WiresRequiredWw({super.key, required this.meshItem});

  @override
  State<WiresRequiredWw> createState() => _WiresRequiredWwState();
}

class _WiresRequiredWwState extends State<WiresRequiredWw> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WiresRequiredWwProvider>(context, listen: false).clearController();
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
        title: Text(
          widget.meshItem.title,
          style: TextStyle(color: AppColors().cFFFFFF, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        child: Consumer<WiresRequiredWwProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Image.asset(widget.meshItem.image, height: 200),
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

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          p.clearController();
                        },
                        child: AppButton().outlinedButton(AppString.clear, context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          p.calculate();
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => _WiresRequiredDialog(
                              numberOfLineWires: p.numberOfLineWires,
                              numberOfCrossWires: p.numberOfCrossWires,
                            ),
                          );
                        },
                        child: AppButton().appButton(AppString.calculate, context),
                      ),
                    ),
                  ],
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
  final double numberOfLineWires;
  final double numberOfCrossWires;

  const _WiresRequiredDialog({
    required this.numberOfLineWires,
    required this.numberOfCrossWires,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmall = size.width < 360;
    final bool isTablet = size.width >= 600;
    final double dialogWidth = isTablet ? 460 : size.width * .92;

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
                padding: const EdgeInsets.all(24),
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
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.analytics_outlined, size: 22, color: AppColors().c1F5F8B),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Text(
                            AppString.result,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        IconButton(
                          splashRadius: 20,
                          icon: const Icon(Icons.close, size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant.withOpacity(.35),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Expanded(flex: 3, child: Text("Number of Line Wires", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600))),
                                Expanded(flex: 2, child: Text(numberOfLineWires.toInt().toString(), textAlign: TextAlign.end, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors().c1F5F8B))),
                              ],
                            ),
                          ),
                          Divider(height: 1, thickness: .6, color: Colors.grey.shade300),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Expanded(flex: 3, child: Text("Number of Cross Wires", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600))),
                                Expanded(flex: 2, child: Text(numberOfCrossWires.toInt().toString(), textAlign: TextAlign.end, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors().c1F5F8B))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
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
    );
  }
}
