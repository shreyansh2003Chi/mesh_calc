import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/chain_link.dart';
import 'package:measurements/pages/weight_per_role.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';

class MeshHomePage extends StatefulWidget {
  const MeshHomePage({super.key});

  @override
  State<MeshHomePage> createState() => _MeshHomePageState();
}

class _MeshHomePageState extends State<MeshHomePage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final List<MeshItem> _allItems = [MeshItem(title: "Weight Per Role", image: AppAssets.weightPerRole), MeshItem(title: "Chain Link", image: AppAssets.chainLink)];

  List<MeshItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _filter(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cFaFaFa,
      body: Column(
        children: [
          _modernHeader(),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              itemCount: _filteredItems.length,
              separatorBuilder: (_, _) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return _modernCard(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _modernHeader() {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors().c1F5F8B,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 4),
              const Text(
                AppString.vMiCalculator,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.8),
              ),

              const SizedBox(height: 22),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.35)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.white, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchCtrl,
                              onChanged: (value) {
                                setState(() {}); // updates clear icon
                                _filter(value);
                              },
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                              decoration: const InputDecoration(
                                hintText: "Search calculators...",
                                hintStyle: TextStyle(color: Colors.white70),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_searchCtrl.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchCtrl.clear();
                                _filter("");
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.25)),
                                child: const Icon(Icons.close, size: 16, color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modernCard(BuildContext context, MeshItem item) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        if (item.title == AppString.chainLink) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChainLinkScreen(item: item)));
        } else if (item.title == AppString.weightPerRole) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRole(meshItem: item)));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 18, offset: const Offset(0, 10))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(item.image, width: 70, height: 70, fit: BoxFit.cover),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(item.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
