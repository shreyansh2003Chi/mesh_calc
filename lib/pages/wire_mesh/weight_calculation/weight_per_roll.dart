import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/utils/wiremesh_result_dialog.dart';
import 'package:measurements/providers/wire_mesh/weight_calculation_providers/weight_calculation_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class WireMeshWeightPerRoll extends StatefulWidget {
  final MeshItem meshItem;

  const WireMeshWeightPerRoll({super.key, required this.meshItem});

  @override
  State<WireMeshWeightPerRoll> createState() => _WireMeshWeightPerRollState();
}

class _WireMeshWeightPerRollState extends State<WireMeshWeightPerRoll> {
  @override
  void initState() {
    Provider.of<WeightCalculationProvider>(context, listen: false).clearController();
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
          "Weight per Roll",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        child: Consumer<WeightCalculationProvider>(
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
                MeasurementField(controller: p.widthCtrl, label: AppString.widthW, unit: p.widthUnit, onUnitChanged: p.setWidthUnit),
                const SizedBox(height: 16),
                MeasurementField(controller: p.lengthCtrl, label: AppString.lengthL, unit: p.lengthUnit, onUnitChanged: p.setLengthUnit),

                const SizedBox(height: 18),
                AppTextField().textField(p.wastageCtrl, "${AppString.wastage} (%)"),
                const SizedBox(height: 18),
                AppTextField().textField(p.costCtrl, AppString.costPerKg),
                const SizedBox(height: 18),
                Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: AppColors().cEAEAEA, borderRadius: BorderRadius.circular(12)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: p.selectedCrimp ?? p.crimpList[0],
                      items: p.crimpList.map((u) {
                        return DropdownMenuItem<String>(value: u, child: Text(u));
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) {
                          p.setSelectedCrimpPercentage(v);
                        }
                      },
                    ),
                  ),
                ),
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
                            builder: (_) => WiremeshResultDialog(
                              totalWeight: p.totalWeight,
                              totalCost: p.totalCost,
                              areaOfWireMesh: p.areaOfWireMesh,
                              numberOfCrossWires: p.numberOfCrossWires,
                              numberOfLineWires: p.numberOfLineWires,
                              weightWithoutWastage: p.weightWithoutWastage,
                              weightWithWastage: p.weightWithWastage,
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
