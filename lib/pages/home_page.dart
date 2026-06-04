import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:measurements/pages/chain_link/chain_link.dart';
import 'package:measurements/pages/welded_wiremesh/weight_per_role.dart';
import 'package:measurements/providers/home_page_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/grid_card.dart';
import 'package:measurements/utils/list_card.dart';
import 'package:provider/provider.dart';

class MeshHomePage extends StatefulWidget {
  const MeshHomePage({super.key});

  @override
  State<MeshHomePage> createState() => _MeshHomePageState();
}

class _MeshHomePageState extends State<MeshHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
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
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
