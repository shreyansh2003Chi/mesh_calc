import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/dynamic_calculator_page.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_colors.dart';

class MeshHomePage extends StatelessWidget {
  MeshHomePage({super.key});

  final List<MeshItem> items = [
    MeshItem(title: "Weight Per Role", image: AppAssets.weightPerRole),
    MeshItem(title: "Chain Link", image: AppAssets.chainLink),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: Text("Mesh Calc", style: TextStyle(color: AppColors().cFFFFFF)),
        elevation: 0,
        backgroundColor: AppColors().c7A3F3F,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return MeshCard(item: items[index]);
        },
      ),
    );
  }
}

class MeshCard extends StatelessWidget {
  final MeshItem item;

  const MeshCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicCalculatorPage(meshItem: item)));
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 14, offset: const Offset(0, 8))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),

              child: Image.asset(item.image, width: 72, height: 72, fit: BoxFit.cover),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                item.title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: Colors.brown.shade800,
                ),
              ),
            ),

            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
