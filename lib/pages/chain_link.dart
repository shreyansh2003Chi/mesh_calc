import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class ChainLinkScreen extends StatefulWidget {
  final MeshItem item;

  const ChainLinkScreen({super.key, required this.item});

  @override
  State<ChainLinkScreen> createState() => _ChainLinkScreenState();
}

class _ChainLinkScreenState extends State<ChainLinkScreen> {
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
      backgroundColor: AppColors().cf5F6FA,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors().c5B2C2C,
        title: Text(
          AppString.chainLinkCalculator,
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors().cFFFFFF),
        ),
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        child: Consumer<ChainLinkProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Column(
                  children: [
                    Image.asset(AppAssets.chainLink, height: 200, fit: BoxFit.contain),
                    const SizedBox(height: 12),
                    const Text(
                      AppString.chainLinkFenceParameters,
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
                                style: TextStyle(color: p.selectedMaterial.color, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, color: p.selectedMaterial.color),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    MeasurementField(controller: p.openingCtrl, label: AppString.openingOpgMm, unit: p.openingUnit, onUnitChanged: p.setOpeningUnit),

                    const SizedBox(height: 18),

                    MeasurementField(controller: p.diameterCtrl, label: AppString.wireDiameter, unit: p.diameterUnit, onUnitChanged: p.setDiameterUnit),

                    const SizedBox(height: 18),

                    MeasurementField(controller: p.widthCtrl, label: AppString.widthW, unit: p.widthUnit, onUnitChanged: p.setWidthUnit),

                    const SizedBox(height: 18),

                    MeasurementField(controller: p.lengthCtrl, label: AppString.lengthL, unit: p.lengthUnit, onUnitChanged: p.setLengthUnit),

                    const SizedBox(height: 18),

                    AppTextField().textField(p.wastageCtrl, "${AppString.wastage} (%)"),

                    const SizedBox(height: 18),

                    AppTextField().textField(p.costCtrl, AppString.costPerKg),
                  ],
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    p.calculate();
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => ChainLinkResultDialog(totalWeight: p.totalWeight, totalCost: p.totalCost),
                    );
                  },
                  child: AppButton().appButton(AppString.calculate),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
