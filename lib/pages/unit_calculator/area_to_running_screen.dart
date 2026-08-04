import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/providers/unit_calculator/area_to_running_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:provider/provider.dart';

class AreaToRunningScreen extends StatelessWidget {
  final MeshItem meshItem;

  const AreaToRunningScreen({super.key, required this.meshItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cFaFaFa,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          meshItem.title,
          style: TextStyle(color: AppColors().cFFFFFF, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors().c1F5F8B,
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
      ),
      body: Consumer<AreaToRunningProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: provider.selectedUnit,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    onChanged: (val) {
                      if (val != null) provider.setUnit(val);
                    },
                    items: provider.units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: AppColors().c464646,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(height: 1, color: Colors.grey),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        provider.selectedUnit + ":",
                        style: TextStyle(
                          color: AppColors().c757575,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: provider.priceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 18, color: AppColors().c212121),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(bottom: 4),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        provider.widthLabel,
                        style: TextStyle(
                          color: AppColors().c757575,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: provider.widthController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 18, color: AppColors().c212121),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(bottom: 4),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors().cF2F2F2,
                    border: Border.all(color: Colors.black87, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          provider.resultLabel,
                          style: TextStyle(
                            color: AppColors().c757575,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Text(
                          provider.resultText,
                          style: TextStyle(
                            color: AppColors().c757575,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    provider.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    "CLEAR",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
