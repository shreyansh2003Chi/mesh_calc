import 'package:flutter/material.dart';
import 'package:measurements/utils/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedUnit = "MM";
  String selectedMaterial = "Mild Steel";
  bool darkMode = false;
  double wastage = 5;
  int precision = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cFAF5F5,

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle("Calculation"),
          _card(
            child: Column(
              children: [
                _dropdownTile(
                  title: "Unit System",
                  value: selectedUnit,
                  items: const ["MM", "CM", "Meter"],
                  onChanged: (v) => setState(() => selectedUnit = v),
                ),
                _sliderTile(
                  title: "Default Wastage (%)",
                  value: wastage,
                  min: 0,
                  max: 15,
                  onChanged: (v) => setState(() => wastage = v),
                ),
                _dropdownTile(
                  title: "Decimal Precision",
                  value: precision.toString(),
                  items: const ["1", "2", "3"],
                  onChanged: (v) => setState(() => precision = int.parse(v)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _sectionTitle("Material"),
          _card(
            child: Column(
              children: [
                _dropdownTile(
                  title: "Default Material",
                  value: selectedMaterial,
                  items: const ["Mild Steel", "GI", "PVC Coated", "Stainless Steel"],
                  onChanged: (v) => setState(() => selectedMaterial = v),
                ),
                _simpleTile(
                  title: "Custom Density",
                  subtitle: "Override material density",
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // open bottom sheet
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _sectionTitle("App"),
          _card(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Dark Mode"),
                  value: darkMode,
                  activeColor: AppColors().c5B2C2C,
                  onChanged: (v) => setState(() => darkMode = v),
                ),
                _simpleTile(
                  title: "Reset All Settings",
                  subtitle: "Restore default values",
                  trailing: Icon(Icons.restart_alt, color: Colors.red.shade400),
                  onTap: _showResetDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------ UI HELPERS ------------------

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors().c5B2C2C),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors().cF1E6E6, borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }

  Widget _dropdownTile({
    required String title,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => onChanged(v!),
      ),
    );
  }

  Widget _sliderTile({
    required String title,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title (${value.toStringAsFixed(0)}%)"),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: AppColors().c5B2C2C,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _simpleTile({required String title, String? subtitle, Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reset Settings"),
        content: const Text("Are you sure you want to reset all settings?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors().c5B2C2C),
            onPressed: () {
              setState(() {
                selectedUnit = "MM";
                selectedMaterial = "Mild Steel";
                wastage = 5;
                precision = 2;
                darkMode = false;
              });
              Navigator.pop(context);
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }
}
