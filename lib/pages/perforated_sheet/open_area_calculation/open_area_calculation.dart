import 'package:flutter/material.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/open_area_calculation_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:provider/provider.dart';

class OpenAreaCalculation extends StatefulWidget {
  const OpenAreaCalculation({super.key});

  @override
  State<OpenAreaCalculation> createState() => _OpenAreaCalculationState();
}
class _OpenAreaCalculationState extends State<OpenAreaCalculation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OpenAreaCalculationProvider>(
      builder: (BuildContext context, pr, Widget? child) {
        return Scaffold(
          backgroundColor: AppColors().cFaFaFa,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors().c1F5F8B,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppString.vMiCalculator,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                            IconButton(
                              color: AppColors().cFFFFFF,
                              onPressed: () {
                                pr.changeView();
                              },
                              icon: pr.isGridView
                                  ? Icon(Icons.format_list_bulleted_outlined)
                                  : Icon(Icons.grid_view_rounded),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.95, end: 1).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: pr.isGridView == false
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          itemCount: pr.allItems.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final item = pr.allItems[index];
                            return InkWell(
                              borderRadius: BorderRadius.circular(24),
                              onTap: () {
                                pr.pageChange(item, context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppColors().cFaFaFa,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 18,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(item.image, width: 70, height: 70, fit: BoxFit.cover),
                                    ),
                                    const SizedBox(width: 18),
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          itemCount: pr.allItems.length,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 220,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            childAspectRatio: 0.85,
                          ),
                          itemBuilder: (context, index) {
                            final item = pr.allItems[index];

                            return InkWell(
                              borderRadius: BorderRadius.circular(24),
                              onTap: () {
                                pr.pageChange(item, context);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppColors().cFaFaFa,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 20,
                                      offset: const Offset(0, 12),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Image.asset(item.image, fit: BoxFit.contain),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      item.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
