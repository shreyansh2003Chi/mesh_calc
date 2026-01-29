import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors().c5B2C2C,
        title: const Text(
          AppString.chainLinkCalculator,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<ChainLinkProvider>(
          builder: (context, p, child) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 14, offset: const Offset(0, 6))],
                  ),
                  child: Column(
                    children: [
                      Image.asset(AppAssets.chainLink, height: 160, fit: BoxFit.contain),
                      const SizedBox(height: 12),
                      const Text(
                        AppString.chainLinkFenceParameters,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12)],
                  ),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: p.material,
                        decoration: InputDecoration(
                          labelText: AppString.material,
                          filled: true,
                          fillColor: const Color(0xFFF1F2F6),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        items: p.materialK.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) {
                          p.material = v!;
                        },
                      ),
                      const SizedBox(height: 12),
                      AppTextField().textField(p.openingCtrl, AppString.openingOpgMm),
                      SizedBox(height: 18),
                      AppTextField().textField(p.wireCtrl, AppString.wireDiameterWdMm),
                      SizedBox(height: 18),
                      AppTextField().textField(p.widthCtrl, AppString.widthWmm),
                      SizedBox(height: 18),
                      AppTextField().textField(p.lengthCtrl, AppString.lengthLmm),
                      SizedBox(height: 18),
                      AppTextField().textField(p.wastageCtrl, "${AppString.wastage} (%)"),
                      SizedBox(height: 18),
                      AppTextField().textField(p.costCtrl, AppString.costPerKg),
                    ],
                  ),
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
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.all(Radius.circular(14))),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppString.totalWeight, style: Theme.of(context).textTheme.labelLarge),
                            Text(p.totalWeight.toStringAsFixed(2), style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppString.totalCost, style: Theme.of(context).textTheme.labelLarge),
                            Text('₹ ${p.totalCost.toStringAsFixed(2)}', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500)),
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
