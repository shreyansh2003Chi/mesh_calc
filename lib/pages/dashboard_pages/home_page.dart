import 'package:flutter/material.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().cFAF5F5,

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: List.generate(10, (index) {
            return Material(
              color: AppColors().cF1E6E6,
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.08),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors().c5B2C2C.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                        child: Image.asset(AppAssets.chainLink, width: 28, height: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          AppString.chainLink,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors().c2B1414),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors().c5B2C2C, borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.calculate_outlined, size: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
