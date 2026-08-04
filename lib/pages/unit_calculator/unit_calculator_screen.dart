import 'package:flutter/material.dart';
import 'package:measurements/providers/global_view_provider.dart';
import 'package:measurements/providers/unit_calculator/unit_calculator_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/grid_card.dart';
import 'package:measurements/utils/list_card.dart';
import 'package:provider/provider.dart';

class UnitCalculatorScreen extends StatefulWidget {
  const UnitCalculatorScreen({super.key});

  @override
  State<UnitCalculatorScreen> createState() => _UnitCalculatorScreenState();
}

class _UnitCalculatorScreenState extends State<UnitCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    final globalView = Provider.of<GlobalViewProvider>(context);
    return Consumer<UnitCalculatorProvider>(
      builder: (BuildContext context, pr, Widget? child) {
        return Scaffold(
          backgroundColor: AppColors().cFaFaFa,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors().c1F5F8B,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(0)),
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
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Text(
                              AppString.unitCalculator,
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
                                globalView.changeView();
                              },
                              icon: globalView.isGridView
                                  ? const Icon(Icons.format_list_bulleted_outlined)
                                  : const Icon(Icons.grid_view_rounded),
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
                  child: globalView.isGridView == false
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          itemCount: pr.allItems.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final item = pr.allItems[index];
                            return ListCard(
                              image: item.image,
                              title: item.title,
                              onTap: () {
                                pr.pageChange(item, context);
                              },
                            );
                          },
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                          itemCount: pr.allItems.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.78,
                          ),
                          itemBuilder: (context, index) {
                            final item = pr.allItems[index];
                            return GridCard(
                              image: item.image,
                              title: item.title,
                              onTap: () {
                                pr.pageChange(item, context);
                              },
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
