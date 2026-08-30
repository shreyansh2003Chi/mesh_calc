import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/welded_wiremesh_provided/weight_per_od_less_id_ww_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class WeightPerOdLessIdWw extends StatefulWidget {
  final MeshItem meshItem;

  const WeightPerOdLessIdWw({super.key, required this.meshItem});

  @override
  State<WeightPerOdLessIdWw> createState() => _WeightPerOdLessIdWwState();
}

class _WeightPerOdLessIdWwState extends State<WeightPerOdLessIdWw> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeightPerOdLessIdWwProvider>(context, listen: false).clearController();
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
        child: Consumer<WeightPerOdLessIdWwProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Image.asset(widget.meshItem.image, height: 200),
                const SizedBox(height: 12),
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
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: p.selectedMaterial.color),
                      color: p.selectedMaterial.color.withOpacity(0.12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 7, backgroundColor: p.selectedMaterial.color),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            p.selectedMaterial.name,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.selectedMaterial.color, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: p.selectedMaterial.color),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                MeasurementField(controller: p.widthOpeningCtrl, label: AppString.widthOpeningWopgMm, unit: p.widthOpeningUnit, onUnitChanged: p.setWidthOpeningUnit),
                const SizedBox(height: 16),
                MeasurementField(controller: p.wireDiameterWidthCtrl, label: AppString.wireDiameter, unit: p.widthDiameterUnit, onUnitChanged: p.setWidthDiameterUnit),

                const SizedBox(height: 16),
                MeasurementField(controller: p.lengthOpeningCtrl, label: AppString.lengthOpeningLOPG, unit: p.lengthOpeningUnit, onUnitChanged: p.setLengthOpeningUnit),
                const SizedBox(height: 16),
                MeasurementField(controller: p.wireDiameterLengthCtrl, label: AppString.wireDiameter, unit: p.lengthDiameterUnit, onUnitChanged: p.setLengthDiameterUnit),

                const SizedBox(height: 16),
                MeasurementField(controller: p.outerDiameterCtrl, label: AppString.outerDiameter, unit: p.outerDiameterUnit, onUnitChanged: p.setOuterDiameterUnit),

                const SizedBox(height: 16),
                MeasurementField(controller: p.innerDiameterCtrl, label: AppString.innerDiameter, unit: p.innerDiameterUnit, onUnitChanged: p.setInnerDiameterUnit),

                const SizedBox(height: 18),
                AppTextField().textField(p.wastageCtrl, "${AppString.wastage} (%)"),
                const SizedBox(height: 18),
                AppTextField().textField(p.costCtrl, AppString.costPerKg),
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
                            builder: (_) => ResultDialog(
                              totalWeight: p.totalWeight,
                              totalCost: p.totalCost,
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
