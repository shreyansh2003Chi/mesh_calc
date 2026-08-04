import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/material_selection_bottom_sheet.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/wire/re_enforced_bar_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class ReEnforcedBarScreen extends StatefulWidget {
  final MeshItem meshItem;

  const ReEnforcedBarScreen({super.key, required this.meshItem});

  @override
  State<ReEnforcedBarScreen> createState() => _ReEnforcedBarScreenState();
}

class _ReEnforcedBarScreenState extends State<ReEnforcedBarScreen> {
  @override
  void initState() {
    Provider.of<ReEnforcedBarProvider>(context, listen: false).clearController();
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
        child: Consumer<ReEnforcedBarProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Image.asset(widget.meshItem.image, height: 200),
                const SizedBox(height: 12),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${AppString.material} :",
                    style: TextStyle(color: AppColors().c757575, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 8),
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
                    height: 54,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            p.selectedMaterial.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors().c212121, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(Icons.signal_cellular_4_bar_rounded, color: Colors.grey, size: 20),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                MeasurementField(controller: p.diameterCtrl, label: AppString.wireDiameterWd, unit: p.diameterUnit, onUnitChanged: p.setDiameterUnit),
                const SizedBox(height: 16),
                MeasurementField(controller: p.lengthCtrl, label: AppString.lengthL, unit: p.lengthUnit, onUnitChanged: p.setLengthUnit),

                const SizedBox(height: 18),
                AppTextField().textField(p.costCtrl, AppString.costPerKg),
                
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
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
                    child: AppButton().appButton(AppString.calculate.toUpperCase(), context),
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
