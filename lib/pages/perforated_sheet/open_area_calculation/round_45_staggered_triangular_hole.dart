import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/capsule_center_to_center_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/capsule_staggered_triangular_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/hexagonal_staggered_triangular_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/round_45_staggered_triangular_hole_provider.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class Round45StaggeredTriangularHole extends StatefulWidget {
  final MeshItem item;

  const Round45StaggeredTriangularHole({super.key, required this.item});

  @override
  State<Round45StaggeredTriangularHole> createState() => _Round45StaggeredTriangularHoleState();
}

class _Round45StaggeredTriangularHoleState extends State<Round45StaggeredTriangularHole> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Round45StaggeredTriangularHoleProvider>(context, listen: false).clearControllers();
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
          AppString.round45StaggeredTriangularHole,
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors().cFFFFFF),
        ),
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Consumer<Round45StaggeredTriangularHoleProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Column(
                  children: [
                    Image.asset(AppAssets.round45StaggeredTriangularHole, height: 200, fit: BoxFit.contain),
                    const SizedBox(height: 12),
                    const Text(
                      AppString.round45StaggeredTriangularHole,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Column(
                  children: [
                    const SizedBox(height: 20),
                    MeasurementField(
                      controller: p.holeDiameterCtrl,
                      label: AppString.holeDiameter,
                      unit: p.holeDiameterUnit,
                      onUnitChanged: p.setHoleDiameterUnit,
                    ),

                    const SizedBox(height: 18),

                    MeasurementField(
                      controller: p.pitchCtrl,
                      label: AppString.pitch,
                      unit: p.pitchUnit,
                      onUnitChanged: p.setPitchUnit,
                    ),

                    const SizedBox(height: 18),
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
