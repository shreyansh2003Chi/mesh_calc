import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/capsule_center_to_center_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/capsule_staggered_triangular_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/hexagonal_staggered_triangular_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/rectangular_center_to_center_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/rectangular_staggered_triangular_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/square_staggered_triangular_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/square_center_to_center_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/round_60_staggered_triangular_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/round_90_center_to_center_hole_wpr.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_roll/round_45_staggered_triangular_hole_wpr.dart';
import 'package:measurements/providers/global_view_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/grid_card.dart';
import 'package:measurements/utils/list_card.dart';
import 'package:provider/provider.dart';

class WeightPerRoll extends StatefulWidget {
  const WeightPerRoll({super.key});

  @override
  State<WeightPerRoll> createState() => _WeightPerRollState();
}

class _WeightPerRollState extends State<WeightPerRoll> {
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.capsuleCenterToCenterHole, image: "assets/WPR/capsule_center_to_center_hole.jpeg"),
    MeshItem(title: AppString.capsuleStaggeredTriangularHole, image: "assets/WPR/capsule_staggered_triangular_hole.jpeg"),
    MeshItem(title: AppString.hexagonalStaggeredTriangularHole, image: "assets/WPR/hexagonal_staggered_triangular_hole.jpeg"),
    MeshItem(title: AppString.rectangularCenterToCenterHole, image: "assets/WPR/rectangular_center_to_center_hole.jpeg"),
    MeshItem(title: AppString.rectangularStaggeredTriangularHole, image: "assets/WPR/rectangular_staggered_triangular_hole.jpeg"),
    MeshItem(title: AppString.squareStaggeredTriangularHole, image: "assets/WPR/square_staggered_triangular_hole.jpeg"),
    MeshItem(title: AppString.squareCenterToCenterHole, image: "assets/WPR/square_cenetr_to_center_hole.jpeg"),
    MeshItem(title: AppString.round60StaggeredTriangularHole, image: "assets/WPR/round_60_staggered_triangular_hole.jpeg"),
    MeshItem(title: AppString.round90CenterToCenterHole, image: "assets/WPR/round_90_center_to_center_hole.jpeg"),
    MeshItem(title: AppString.round45StaggeredTriangularHole, image: "assets/WPR/round_45_staggered_triangular_hole.jpeg"),
  ];

  void pageChange(MeshItem meshItem) {
    switch (meshItem.title) {
      case AppString.capsuleCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleCenterToCenterHoleWpr(item: meshItem)));
        break;
      case AppString.capsuleStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleStaggeredTriangularHoleWpr(item: meshItem)));
        break;
      case AppString.hexagonalStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HexagonalStaggeredTriangularHoleWpr(item: meshItem)));
        break;
      case AppString.rectangularCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularCenterToCenterHoleWpr(item: meshItem)));
        break;
      case AppString.rectangularStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularStaggeredTriangularHoleWpr(item: meshItem)));
        break;
      case AppString.squareStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SquareStaggeredTriangularHoleWpr(item: meshItem)));
        break;
      case AppString.squareCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SquareCenterToCenterHoleWpr(item: meshItem)));
        break;
      case AppString.round60StaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round60StaggeredTriangularHoleWpr(item: meshItem)));
        break;
      case AppString.round90CenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round90CenterToCenterHoleWpr(item: meshItem)));
        break;
      case AppString.round45StaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round45StaggeredTriangularHoleWpr(item: meshItem)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalView = Provider.of<GlobalViewProvider>(context);
    return Scaffold(
      backgroundColor: AppColors().cFaFaFa,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors().c1F5F8B,
        title: const Text(
          "Weight Per Roll",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              globalView.changeView();
            },
            icon: globalView.isGridView
                ? const Icon(Icons.format_list_bulleted_outlined)
                : const Icon(Icons.grid_view_rounded),
          ),
        ],
      ),
      body: AnimatedSwitcher(
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
                itemCount: allItems.length,
                separatorBuilder: (_, _) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final item = allItems[index];
                  return ListCard(
                    image: item.image,
                    title: item.title,
                    onTap: () {
                      pageChange(item);
                    },
                  );
                },
              )
            : GridView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                itemCount: allItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final item = allItems[index];
                  return GridCard(
                    image: item.image,
                    title: item.title,
                    onTap: () {
                      pageChange(item);
                    },
                  );
                },
              ),
      ),
    );
  }
}
