import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/providers/wire_mesh/weight_per_od_less_id_provider.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class WeightPerOdLessId extends StatefulWidget {
  final MeshItem item;

  const WeightPerOdLessId({super.key, required this.item});

  @override
  State<WeightPerOdLessId> createState() => _WeightPerOdLessIdState();
}

class _WeightPerOdLessIdState extends State<WeightPerOdLessId> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChainLinkProvider>(context, listen: false).clearControllers();
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
          AppString.weightPerOdLessId,
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors().cFFFFFF),
        ),
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        child: Consumer<WeightPerOdLessIdProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Column(
                  children: [
                    Image.asset(AppAssets.weightPerOdLessId2, height: 200, fit: BoxFit.contain),
                    const SizedBox(height: 12),
                    const Text(
                      AppString.weightPerOdLessId,
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

                    MeasurementField(controller: p.widthMeshCtrl, label: AppString.widthMesh, showUnit: false),

                    const SizedBox(height: 18),

                    MeasurementField(
                      controller: p.wireDiameterOneCtrl,
                      label: AppString.wireDiameter,
                      unit: p.wireDiameterOneUnit,
                      onUnitChanged: p.setWireDiameterOneUnit,
                    ),

                    const SizedBox(height: 18),

                    MeasurementField(controller: p.lengthMeshCtrl, label: AppString.lengthMesh, showUnit: false),

                    const SizedBox(height: 18),

                    MeasurementField(
                      controller: p.wireDiameterTwoCtrl,
                      label: AppString.wireDiameter,
                      unit: p.wireDiameterTwoUnit,
                      onUnitChanged: p.setWireDiameterTwoUnit,
                    ),
                    const SizedBox(height: 18),
                    MeasurementField(
                      controller: p.outerDiameterCtrl,
                      label: AppString.outerDiameter,
                      unit: p.outerDiameterUnit,
                      onUnitChanged: p.setOuterDiameterUnit,
                    ),

                    const SizedBox(height: 18),
                    MeasurementField(
                      controller: p.innerDiameterCtrl,
                      label: AppString.innerDiameter,
                      unit: p.innerDiameterUnit,
                      onUnitChanged: p.setInnerDiameterUnit,
                    ),

                    const SizedBox(height: 18),

                    AppTextField().textField(p.wastageCtrl, "${AppString.wastage} (%)"),

                    const SizedBox(height: 18),

                    AppTextField().textField(p.costPerKgCtrl, AppString.costPerKg),
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
