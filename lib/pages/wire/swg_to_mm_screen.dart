import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/providers/wire/swg_to_mm_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SwgToMmScreen extends StatelessWidget {
  final MeshItem meshItem;

  const SwgToMmScreen({super.key, required this.meshItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cFaFaFa,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors().c1F5F8B,
        iconTheme: IconThemeData(color: AppColors().cFFFFFF),
        title: Text(
          meshItem.title,
          style: TextStyle(color: AppColors().cFFFFFF, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
        child: Consumer<SwgToMmProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: provider.selectedGauge,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        provider.setSelectedGauge(newValue);
                      }
                    },
                    items: provider.swgToMmMap.keys.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(
                            value,
                            style: TextStyle(
                              color: AppColors().c212121,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.only(top: 8, bottom: 24),
                ),
                const Icon(
                  Icons.swap_vert,
                  size: 42,
                  color: Colors.black87,
                ),
                const SizedBox(height: 24),
                Text(
                  "${provider.mmValue} mm",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    color: AppColors().c464646,
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
