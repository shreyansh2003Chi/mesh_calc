import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/result_dialog.dart';
import 'package:measurements/providers/wire_mesh/open_area_calculations_providers/harp_wire_mesh_provider.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:provider/provider.dart';

class HarpWireMesh extends StatefulWidget {
  final MeshItem item;

  const HarpWireMesh({super.key, required this.item});

  @override
  State<HarpWireMesh> createState() => _HarpWireMeshState();
}

class _HarpWireMeshState extends State<HarpWireMesh> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HarpWireMeshProvider>(context, listen: false).clearControllers();
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
        child: Consumer<HarpWireMeshProvider>(
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

                    MeasurementField(
                      controller: p.widthOpeningCtrl,
                      label: "Width Opening",
                      unit: p.widthOpeningUnit,
                      onUnitChanged: p.setWidthOpeningUnit,
                    ),
                    const SizedBox(height: 18),
                    MeasurementField(
                      controller: p.wireDiameterCtrl,
                      label: AppString.wireDiameter,
                      unit: p.wireDiameterUnit,
                      onUnitChanged: p.setWireDiameterUnit,
                    ),
                    const SizedBox(height: 18),
                    MeasurementField(
                      controller: p.lengthOpeningCtrl,
                      label: "Length Opening",
                      unit: p.lengthOpeningUnit,
                      onUnitChanged: p.setLengthOpeningUnit,
                    ),
                    const SizedBox(height: 18),
                    MeasurementField(
                      controller: p.lengthOpening1Ctrl,
                      label: "Length Opening 1",
                      unit: p.lengthOpening1Unit,
                      onUnitChanged: p.setLengthOpening1Unit,
                    ),
                    const SizedBox(height: 18),
                    MeasurementField(
                      controller: p.wireDiameter2Ctrl,
                      label: "Wire Diameter 2",
                      unit: p.wireDiameter2Unit,
                      onUnitChanged: p.setWireDiameter2Unit,
                    ),
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
