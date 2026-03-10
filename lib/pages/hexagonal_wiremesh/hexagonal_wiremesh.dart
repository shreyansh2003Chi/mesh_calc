import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/providers/expanded_metal_provider/expanded_metal_provider.dart';
import 'package:measurements/providers/hexagonal_wiremesh_provider/hexagonal_wiremesh_provider.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

import '../pitch_selection_bottom_sheet.dart';

class HexagonalWiremesh extends StatefulWidget {
  final MeshItem item;

  const HexagonalWiremesh({super.key, required this.item});

  @override
  State<HexagonalWiremesh> createState() => _HexagonalWiremeshState();
}

class _HexagonalWiremeshState extends State<HexagonalWiremesh> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HexagonalWiremeshProvider>(context, listen: false).clearControllers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cFaFaFa,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors().c1F5F8B,
        title: Text(
          AppString.hexagonalWiremesh,
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors().cFFFFFF),
        ),
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Consumer<HexagonalWiremeshProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Column(
                  children: [
                    Image.asset(AppAssets.hexagonalWiremeshCore, height: 200, fit: BoxFit.contain),
                    const SizedBox(height: 12),
                    const Text(
                      AppString.expandedMetal,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return MaterialSelectionBottomSheet();
                          },
                        ).then((value) {
                          if (value != null) {
                            p.setSelectedMaterial(value);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: p.selectedMaterial.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: p.selectedMaterial.color, width: 1.4),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(color: p.selectedMaterial.color, shape: BoxShape.circle),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                p.selectedMaterial.name,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: p.selectedMaterial.color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, color: p.selectedMaterial.color),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return PitchSelectionBottomSheet();
                          },
                        ).then((value) {
                          if (value != null) {
                            p.setPitch(value);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1.4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.straighten),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                p.selectedPitch == null ? "Select Pitch" : "${p.selectedPitch} mm",
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    MeasurementField(
                      controller: p.wireDiameterController,
                      label: AppString.thickness,
                      unit: p.wireDiameterUnit,
                      onUnitChanged: p.setWireDiameterUnit,
                    ),
                    const SizedBox(height: 18),
                    MeasurementField(
                      controller: p.widthController,
                      label: AppString.widthW,
                      unit: p.widthUnit,
                      onUnitChanged: p.setWidthUnit,
                    ),

                    const SizedBox(height: 18),
                    MeasurementField(
                      controller: p.lengthController,
                      label: AppString.lengthL,
                      unit: p.lengthUnit,
                      onUnitChanged: p.setLengthUnit,
                    ),
                    const SizedBox(height: 18),
                    AppTextField().textField(p.wastageController, AppString.wastage),
                    const SizedBox(height: 18),
                    AppTextField().textField(p.costPerKgController, AppString.costPerKg),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          p.clearControllers();
                        },
                        child: AppButton().outlinedButton(AppString.clear, context),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          p.calculate().then((value) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) => ResultDialog(totalWeight: p.totalWeight, totalCost: p.totalCost),
                            );
                          });
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
