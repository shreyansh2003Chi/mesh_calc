import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/dynamic_calculator_page_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class DynamicCalculatorPage extends StatefulWidget {
  final MeshItem meshItem;

  const DynamicCalculatorPage({super.key, required this.meshItem});

  @override
  State<DynamicCalculatorPage> createState() => _DynamicCalculatorPageState();
}

class _DynamicCalculatorPageState extends State<DynamicCalculatorPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DynamicCalculatorPageProvider>(context, listen: false).init(meshItem: widget.meshItem);
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
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
        backgroundColor: AppColors().c5B2C2C,

        title: Text(
          widget.meshItem.title,
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors().cFFFFFF),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<DynamicCalculatorPageProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Column(
                  children: [
                    Image.asset(widget.meshItem.image, height: 200, fit: BoxFit.contain),
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
                      onTap: () => p.showMaterialBottomSheet(context, p),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: p.materialModel.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: p.materialModel.color, width: 1.4),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(color: p.materialModel.color, shape: BoxShape.circle),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                p.materialModel.name,
                                style: TextStyle(color: p.materialModel.color, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, color: p.materialModel.color),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    p.openingCtrlIsVisible
                        ? MeasurementField(controller: p.openingCtrl, label: AppString.openingOpgMm, unit: p.openingUnit, onUnitChanged: p.setOpeningUnit)
                        : Container(),
                    const SizedBox(height: 18),
                    p.diameterCtrlIsVisible
                        ? MeasurementField(controller: p.diameterCtrl, label: AppString.wDWireDiameter, unit: p.diameterUnit, onUnitChanged: p.setDiameterUnit)
                        : Container(),
                    const SizedBox(height: 18),
                    p.widthCtrlIsVisible ? MeasurementField(controller: p.widthCtrl, label: AppString.widthWmm, unit: p.widthUnit, onUnitChanged: p.setWidthUnit) : Container(),
                    const SizedBox(height: 18),
                    p.lengthCtrlIsVisible
                        ? MeasurementField(controller: p.lengthCtrl, label: AppString.lengthLmm, unit: p.lengthUnit, onUnitChanged: p.setLengthUnit)
                        : Container(),
                    const SizedBox(height: 18),
                    p.wastageCtrlIsVisible ? AppTextField().textField(p.wastageCtrl, "${AppString.wastage} (%)") : Container(),
                    const SizedBox(height: 18),
                    p.costCtrlIsVisible ? AppTextField().textField(p.costCtrl, AppString.costPerKg) : Container(),
                  ],
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    p.calculate(meshItem: widget.meshItem);
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
