import 'package:flutter/material.dart';
import 'package:measurements/providers/material_selection_bottom_sheet_provider.dart';
import 'package:provider/provider.dart';

class MaterialSelectionBottomSheet extends StatefulWidget {
  const MaterialSelectionBottomSheet({super.key});

  @override
  State<MaterialSelectionBottomSheet> createState() => _MaterialSelectionBottomSheetState();
}

class _MaterialSelectionBottomSheetState extends State<MaterialSelectionBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MaterialSelectionBottomSheetProvider>(context, listen: false).init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MaterialSelectionBottomSheetProvider>(
      builder: (context, p, child) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
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

                Text("Select Material", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),

                const SizedBox(height: 14),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _searchController,
                      textAlignVertical: TextAlignVertical.center, // ✅ Important
                      onChanged: (value) {
                        p.setSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search materials...",
                        prefixIcon: const Icon(Icons.search, size: 22),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close, size: 20),
                                onPressed: () {
                                  _searchController.clear();
                                  p.setSearchQuery("");
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                const Divider(),

                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

                    itemCount: p.filteredMaterials.length,
                    itemBuilder: (context, index) {
                      final m = p.filteredMaterials[index];
                      final isSelected = m.id == p.material.id;

                      return ListTile(
                        leading: Container(
                          decoration: BoxDecoration(color: m.color.withOpacity(0.2), shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(color: m.color, shape: BoxShape.circle),
                            ),
                          ),
                        ),
                        title: Text(
                          m.name,
                          style: TextStyle(color: m.color, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
                        ),
                        trailing: isSelected ? Icon(Icons.check, color: m.color) : null,
                        onTap: () {
                          p.setSelectedMaterial(m);
                          Navigator.pop(context, m);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
