import 'package:flutter/material.dart';
import 'package:measurements/models/material_model.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_button.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/app_text_field.dart';
import 'package:provider/provider.dart';

class ChainLinkScreen extends StatelessWidget {
  const ChainLinkScreen({super.key});

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
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors().cFFFFFF,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<ChainLinkProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Column(
                  children: [
                    Image.asset(
                      AppAssets.chainLink,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      AppString.chainLinkFenceParameters,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    DropdownButtonFormField<MaterialModel>(
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: p.materialModel.name,
                        filled: true,
                        fillColor: p.materialModel.color.withOpacity(0.12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: p.materialModel.color,
                            width: 1.4,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: p.materialModel.color,
                            width: 1,
                          ),
                        ),
                      ),
                      value: p.materialModel,
                      items: p.materials.map((m) {
                        return DropdownMenuItem(
                          value: m,
                          child: Row(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: m.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(m.name, style: TextStyle(color: m.color)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          p.onMaterialChange(val);
                        }
                      },
                    ),

                    const SizedBox(height: 12),
                    AppTextField().textField(
                      p.openingCtrl,
                      AppString.openingOpgMm,
                    ),
                    SizedBox(height: 18),
                    AppTextField().textField(
                      p.wireCtrl,
                      AppString.wireDiameterWdMm,
                    ),
                    SizedBox(height: 18),
                    AppTextField().textField(p.widthCtrl, AppString.widthWmm),
                    SizedBox(height: 18),
                    AppTextField().textField(p.lengthCtrl, AppString.lengthLmm),
                    SizedBox(height: 18),
                    AppTextField().textField(
                      p.wastageCtrl,
                      "${AppString.wastage} (%)",
                    ),
                    SizedBox(height: 18),
                    AppTextField().textField(p.costCtrl, AppString.costPerKg),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    p.calculate();
                  },
                  child: AppButton().appButton(AppString.calculate),
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppString.totalWeight,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              p.totalWeight.toStringAsFixed(2),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppString.totalCost,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              '₹ ${p.totalCost.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
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
