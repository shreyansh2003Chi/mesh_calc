import 'package:flutter/material.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Responsive column count
    final int crossAxisCount = size.width >= 900
        ? 3
        : size.width >= 600
        ? 2
        : 1;

    return Scaffold(
      backgroundColor: AppColors().cFAF5F5,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: crossAxisCount == 1 ? 4.8 : 2.8,
          ),
          itemBuilder: (context, index) {
            return _ModernCard(title: AppString.chainLink, iconPath: AppAssets.chainLink, onTap: () {});
          },
        ),
      ),
    );
  }
}

class _ModernCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const _ModernCard({required this.title, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors().cF1E6E6,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.08),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        splashColor: AppColors().c5B2C2C.withOpacity(0.15),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14))),
                child: Image.asset(iconPath, width: 45, height: 45),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors().c2B1414),
                ),
              ),

              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: AppColors().cFDFBFB, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.calculate_outlined, size: 18, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
