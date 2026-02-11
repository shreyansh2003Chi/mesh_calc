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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DynamicCalculatorPageProvider>().init(widget.meshItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cf5F6FA,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors().c5B2C2C,
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
        title: Text(
          widget.meshItem.title,
          style: TextStyle(color: AppColors().cFFFFFF, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<DynamicCalculatorPageProvider>(
          builder: (_, p, __) {
            final isChainLink = widget.meshItem.title == AppString.chainLink;

            return Column(
              children: [
                Image.asset(widget.meshItem.image, height: 200),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () => p.showMaterialBottomSheet(context, p),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: p.materialModel.color),
                      color: p.materialModel.color.withOpacity(0.12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 7, backgroundColor: p.materialModel.color),
                        const SizedBox(width: 12),
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

                if (isChainLink) ...[
                  MeasurementField(
                    controller: p.openingCtrl,
                    label: AppString.openingOpgMm,
                    unit: p.openingUnit,
                    onUnitChanged: p.setOpeningUnit,
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: p.diameterCtrl,
                    label: AppString.wDWireDiameter,
                    unit: p.diameterUnit,
                    onUnitChanged: p.setDiameterUnit,
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: p.widthCtrl,
                    label: AppString.widthWmm,
                    unit: p.widthUnit,
                    onUnitChanged: p.setWidthUnit,
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: p.lengthCtrl,
                    label: AppString.lengthLmm,
                    unit: p.lengthUnit,
                    onUnitChanged: p.setLengthUnit,
                  ),
                ],

                if (!isChainLink) ...[
                  MeasurementField(
                    controller: p.widthOpeningCtrl,
                    label: AppString.widthOpeningWopgMm,
                    unit: p.widthOpeningUnit,
                    onUnitChanged: p.setWidthOpeningUnit,
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: p.wireDiameterForWidth,
                    label: AppString.wireDiameterWdMm,
                    unit: p.wireDiameterForWidthUnit,
                    onUnitChanged: p.setWireDiameterWidthUnit,
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: p.lengthOpeningCtrl,
                    label: AppString.openingOpgMm,
                    unit: p.lengthOpeningUnit,
                    onUnitChanged: p.setWireLengthOpeningUnit,
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: p.wireDiameterForLength,
                    label: AppString.wireDiameterWdMm,
                    unit: p.wireDiameterForLengthUnit,
                    onUnitChanged: p.setWireDiameterLengthUnit,
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: p.widthCtrl,
                    label: AppString.widthWmm,
                    unit: p.widthUnit,
                    onUnitChanged: p.setWidthUnit,
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: p.lengthCtrl,
                    label: AppString.lengthLmm,
                    unit: p.lengthUnit,
                    onUnitChanged: p.setLengthUnit,
                  ),
                ],

                const SizedBox(height: 18),
                AppTextField().textField(p.wastageCtrl, "${AppString.wastage} (%)"),
                const SizedBox(height: 18),
                AppTextField().textField(p.costCtrl, AppString.costPerKg),

                const SizedBox(height: 24),

                GestureDetector(
                  onTap: () {
                    p.calculate(meshItem: widget.meshItem);

                    showDialog(
                      context: context,
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
