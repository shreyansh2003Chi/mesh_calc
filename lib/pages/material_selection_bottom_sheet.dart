import 'package:flutter/material.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:provider/provider.dart';

class MaterialSelectionBottomSheet extends StatefulWidget {
  const MaterialSelectionBottomSheet({super.key});

  @override
  State<MaterialSelectionBottomSheet> createState() => _MaterialSelectionBottomSheetState();
}

class _MaterialSelectionBottomSheetState extends State<MaterialSelectionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChainLinkProvider>(
      builder: (context, p, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2)),
              ),

              const SizedBox(height: 14),

              Text(
                "Select Material",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: p.materials.length,
                  itemBuilder: (context, index) {
                    final m = p.materials[index];
                    final isSelected = m.id == p.materialModel.id;

                    return ListTile(
                      leading: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(color: m.color, shape: BoxShape.circle),
                      ),
                      title: Text(
                        m.name,
                        style: TextStyle(color: m.color, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
                      ),
                      trailing: isSelected ? Icon(Icons.check, color: m.color) : null,
                      onTap: () {
                        p.onMaterialChange(m);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
