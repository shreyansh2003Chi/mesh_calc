import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/chain_link.dart';
import 'package:measurements/pages/weight_per_role.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';

class MeshHomePage extends StatelessWidget {
  MeshHomePage({super.key});

  final List<MeshItem> items = [MeshItem(title: "Weight Per Role", image: AppAssets.weightPerRole), MeshItem(title: "Chain Link", image: AppAssets.chainLink)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cFFFFFF,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors().c1F5F8B,
        title: Text(AppString.vMiCalculator, style: TextStyle(color: AppColors().cFFFFFF)),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          var item = items[index];
          return GestureDetector(
            onTap: () {
              if (item.title == AppString.chainLink) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChainLinkScreen(item: item)));
              } else if (item.title == AppString.weightPerRole) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRole(meshItem: item)));
              }
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.8, color: Colors.brown.shade800),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey.shade400),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
