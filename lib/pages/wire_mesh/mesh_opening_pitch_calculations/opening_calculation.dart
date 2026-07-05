import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/opening_calculation_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class OpeningCalculation extends StatefulWidget {
  final MeshItem item;

  const OpeningCalculation({super.key, required this.item});

  @override
  State<OpeningCalculation> createState() => _OpeningCalculationState();
}

class _OpeningCalculationState extends State<OpeningCalculation> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OpeningCalculationProvider>(context, listen: false).clearControllers();
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
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        child: Consumer<OpeningCalculationProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Column(
                  children: [
                    Image.asset(widget.item.image, height: 200, fit: BoxFit.contain),
                    const SizedBox(height: 12),
                    Text(
                      widget.item.title,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    AppTextField().textField(p.meshCtrl, "Mesh"),
                    const SizedBox(height: 18),
                    MeasurementField(controller: p.wireDiameterCtrl, label: "Wire Diameter", unit: p.wireDiameterUnit, onUnitChanged: p.setWireDiameterUnit),
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
