import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/providers/unit_calculator/area_to_area_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:provider/provider.dart';

class AreaToAreaScreen extends StatelessWidget {
  final MeshItem meshItem;

  const AreaToAreaScreen({super.key, required this.meshItem});

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
      body: Consumer<AreaToAreaProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                _buildUnitSection(
                  context,
                  provider.topUnit,
                  provider.units,
                  (newUnit) {
                    if (newUnit != null) provider.setTopUnit(newUnit);
                  },
                  provider.topController,
                ),
                const SizedBox(height: 16),
                IconButton(
                  onPressed: () {
                    provider.swapUnits();
                  },
                  icon: const Icon(Icons.swap_vert, size: 36, color: Colors.black),
                ),
                const SizedBox(height: 16),
                _buildUnitSection(
                  context,
                  provider.bottomUnit,
                  provider.units,
                  (newUnit) {
                    if (newUnit != null) provider.setBottomUnit(newUnit);
                  },
                  provider.bottomController,
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

  Widget _buildUnitSection(
    BuildContext context,
    String selectedUnit,
    List<String> units,
    ValueChanged<String?> onChanged,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedUnit,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            onChanged: onChanged,
            items: units.map<DropdownMenuItem<String>>((String value) {
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
        Container(
          height: 1,
          color: Colors.grey,
        ),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: AppColors().c212121,
          ),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ],
    );
  }
}
