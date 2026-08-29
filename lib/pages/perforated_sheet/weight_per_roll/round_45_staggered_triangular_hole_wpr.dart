import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/perforated_sheet_provider/weight_per_roll_provider/round_45_staggered_triangular_hole_wpr_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class Round45StaggeredTriangularHoleWpr extends StatefulWidget {
  final MeshItem item;

  const Round45StaggeredTriangularHoleWpr({super.key, required this.item});

  @override
  State<Round45StaggeredTriangularHoleWpr> createState() => _Round45StaggeredTriangularHoleWprState();
}

class _Round45StaggeredTriangularHoleWprState extends State<Round45StaggeredTriangularHoleWpr> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Round45StaggeredTriangularHoleWprProvider>(context, listen: false).clearControllers();
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
          widget.item.title,
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors().cFFFFFF),
        ),
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Consumer<Round45StaggeredTriangularHoleWprProvider>(
          builder: (context, p, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/WPR/round_45_staggered_triangular_hole.jpeg", height: 200, fit: BoxFit.contain),
                ),
                const SizedBox(height: 20),
                
                const Text("Material :", style: TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const MaterialSelectionBottomSheet(),
                    );
                    if (result != null) {
                      p.setSelectedMaterial(result);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: p.selectedMaterial?.color.withOpacity(0.12) ?? Colors.grey.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: p.selectedMaterial?.color ?? Colors.grey, width: 1.4),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: p.selectedMaterial?.color ?? Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            p.selectedMaterial?.name ?? "Select Material",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: p.selectedMaterial?.color ?? Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: p.selectedMaterial?.color ?? Colors.grey),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

MeasurementField(
                  controller: p.holeDiameterCtrl,
                  label: "Hole Diameter (HD)",
                  unit: p.holeDiameterUnit,
                  onUnitChanged: p.setHoleDiameterUnit,
                ),
                const SizedBox(height: 18),
                MeasurementField(
                  controller: p.pitchCtrl,
                  label: "Pitch (P)",
                  unit: p.pitchUnit,
                  onUnitChanged: p.setPitchUnit,
                ),
                const SizedBox(height: 18),
                const SizedBox(height: 18),
                MeasurementField(
                  controller: p.thicknessCtrl,
                  label: "Thickness (T)",
                  unit: p.thicknessUnit,
                  onUnitChanged: p.setThicknessUnit,
                ),
                const SizedBox(height: 18),
                MeasurementField(
                  controller: p.sheetWidthCtrl,
                  label: "Sheet Width (SW)",
                  unit: p.sheetWidthUnit,
                  onUnitChanged: p.setSheetWidthUnit,
                ),
                const SizedBox(height: 18),
                MeasurementField(
                  controller: p.sheetLengthCtrl,
                  label: "Sheet Length (SL)",
                  unit: p.sheetLengthUnit,
                  onUnitChanged: p.setSheetLengthUnit,
                ),
                const SizedBox(height: 18),
                MeasurementField(
                  controller: p.perforationWidthCtrl,
                  label: "Perforation Width (PW)",
                  unit: p.perforationWidthUnit,
                  onUnitChanged: p.setPerforationWidthUnit,
                ),
                const SizedBox(height: 18),
                MeasurementField(
                  controller: p.perforationLengthCtrl,
                  label: "Perforation Length (PL)",
                  unit: p.perforationLengthUnit,
                  onUnitChanged: p.setPerforationLengthUnit,
                ),
                const SizedBox(height: 18),
                AppTextField().textField(p.costCtrl, "Cost per KG"),

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
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (p.selectedMaterial == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a material")));
                            return;
                          }
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
